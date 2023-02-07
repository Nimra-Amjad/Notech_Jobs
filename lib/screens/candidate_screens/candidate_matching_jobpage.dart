import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:http/http.dart' as http;
import 'package:notech_mobile_app/screens/candidate_screens/candidate_jobapplypage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/text/custom_text.dart';
import '../../components/utils/app_colors.dart';

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

  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
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

    jobs_match.clear();
    for (String a in alljobs) {
      http.Response response = await http.get(Uri.parse(
          'https://nimraamjad.pythonanywhere.com/api?querycv=$loggedinUser.pdftext&queryjob=$a'));
      match = jsonDecode(response.body);
      jobs_match.clear();
      if (double.parse(match['matching percent']) > 2.0) {
        jobs_match.add(a);
      }
    }
  }

  apply(String uid1, String uid2) async {
    model.Applicants appl = model.Applicants(
        pdfurl: loggedinUser.pdfurl, pdfname: loggedinUser.pdfname);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid1)
        .collection("jobs")
        .doc(uid2)
        .update({
      "applicants": FieldValue.arrayUnion([appl.toJson()])
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CandidateJobApply()));
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
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collectionGroup("jobs")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: jobs_match.length,
                              // scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                DocumentSnapshot jobs =
                                    snapshot.data!.docs[index];
                                print(jobs_match.length);

                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: "Job description",
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.blueColor),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 6.sp),
                                          width: 80.w,
                                          child: CustomText(
                                              text: '${jobs_match[index]}',
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.normal,
                                              fontColor:
                                                  AppColors.quizbluecolor),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        CustomText(
                                            text: "Posted 1 min ago",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            fontColor: AppColors.primaryBlack),
                                        const Divider(
                                          thickness: 0.5,
                                          height: 20.0,
                                          color: Colors.grey,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            apply(jobs['uid'], jobs['id']);
                                          },
                                          child: Container(
                                            width: 150,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: AppColors.blueLight,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: const [
                                                Text(
                                                  "Apply Now",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                Icon(
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
                                // return Text('${jobs_match}');
                              })
                          : const CircularProgressIndicator();
                    });
          }),
    );
  }
}
