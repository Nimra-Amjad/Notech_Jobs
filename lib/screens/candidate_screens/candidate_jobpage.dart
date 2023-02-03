import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:http/http.dart' as http;

import '../../components/utils/colors.dart';

class CandidateJobPage extends StatefulWidget {
  const CandidateJobPage({super.key});

  @override
  State<CandidateJobPage> createState() => _CandidateJobPageState();
}

class _CandidateJobPageState extends State<CandidateJobPage> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Candidate loggedinUser = model.Candidate();
  model.Recruiter companyapply = model.Recruiter();
  model.JobPosted currentjobs = model.JobPosted();

  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    // this.loggedinUser = model.Candidate.fromSnap(snap);
    setState(() {
      loggedinUser = model.Candidate.fromSnap(snap);
    });
  }

  List<String> alljobs = [];
  List<String> jobs_match = [];
  var match;
  getalljobs() async {
    QuerySnapshot feed =
        await FirebaseFirestore.instance.collectionGroup('jobs').get();
    alljobs.clear();
    for (var postDoc in feed.docs) {
      model.JobPosted post = model.JobPosted.fromSnap(postDoc);

      alljobs.add(post.jobdes.toString());
    }
    print(alljobs);

    jobs_match.clear();
    for (String a in alljobs) {
      http.Response response = await http.get(Uri.parse(
          'https://nimraamjad.pythonanywhere.com/api?querycv=$loggedinUser.pdftext&queryjob=$a'));
      match = jsonDecode(response.body);

      if (double.parse(match['matching percent']) > 15.0) {
        jobs_match.add(a);
      }
    }
    print("0000000000000000000000000000000");
    print(jobs_match);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs Posted"),
        backgroundColor: AppColors.blueColor,
      ),
      body: FutureBuilder(
          future: getalljobs(),
          builder: (context, AsyncSnapshot snapshot) {
            return jobs_match.isEmpty
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: jobs_match.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      print(jobs_match.length);
                      return Text('${jobs_match}');
                    });
          }),
    );
      }
}
