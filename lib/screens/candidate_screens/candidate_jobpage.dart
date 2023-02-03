import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/candidate_screens/candidate_jobapplypage.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_sizer/responsive_sizer.dart';

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

  // getapii(String jobs) async {
  // FirebaseFirestore.instance
  //     .collectionGroup("payment")
  //     .get()
  //     .then((QuerySnapshot querySnapshot) {
  //   querySnapshot.docs.forEach((doc) {
  //     print("hehehehehehehehehehehehehehheheheheheheheheheheheh");
  //     print(doc["jobdes"]);
  //     print("hehehehehehehehehehehehehehheheheheheheheheheheheh");
  //   });
  // });
  // QuerySnapshot<Map<String, dynamic>> snap =
  //     await FirebaseFirestore.instance.collectionGroup("jobs").get();
  //   http.Response response = await http.get(Uri.parse(
  //       'https://nimraamjad.pythonanywhere.com/api?querycv=$loggedinUser.pdftext&queryjob=$snap'));
  //   var match = jsonDecode(response.body);
  //   print("hehehehehehehehehehehehehehheheheheheheheheheheheh");
  //   print(snap);
  //   print("hehehehehehehehehehehehehehheheheheheheheheheheheh");
  //   print(match["matching percent"]);
  //   print("hehehehehehehehehehehehehehheheheheheheheheheheheh");
  // }

  String? ress;
  getapi(String jobs) async {
    http.Response response = await http.get(Uri.parse(
        'https://nimraamjad.pythonanywhere.com/api?querycv=$loggedinUser.pdftext&queryjob=$jobs'));
    var match = jsonDecode(response.body);
    print("hellooooooo");
    print(match["matching percent"]);
    print("hellooooooo");
    setState(() {
      ress = match["matching percent"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jobs Posted"),
        backgroundColor: AppColors.blueColor,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collectionGroup("jobs").snapshots(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // String stringJob = snapshot.data!.docs[index]['jobdes'];
                      // print(stringJob);
                      DocumentSnapshot jobs = snapshot.data!.docs[index];
                      String stringJob = jobs['jobdes'];
                      getapi(stringJob);
                      print("000000000000000000000000000000000000000");
                      print(stringJob);
                      print("000000000000000000000000000000000000000");
                      print(ress);
                      print("0000000000000000000000000000000000000");

                      if (ress == "22.94") {
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jobs['jobdes'],
                                  style: const TextStyle(
                                      color: AppColors.blueColor),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                const Text(
                                  "Posted 1 min ago",
                                  style: TextStyle(fontSize: 11),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  height: 20.0,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // getapi();
                                  },
                                  // onTap: jobapply(jobs['id'], jobs['uid']),
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.blueColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          "Apply Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const Icon(
                                          Icons.arrow_upward_outlined,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      } else {
                        SizedBox(
                          height: 10.sp,
                        );
                      }
                    })
                : CircularProgressIndicator();
          }),
    );
  }
}
