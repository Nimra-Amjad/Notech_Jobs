import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_update_job.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/colors.dart';

class RecruiterJobPost extends StatefulWidget {
  const RecruiterJobPost({super.key});

  @override
  State<RecruiterJobPost> createState() => _RecruiterJobPostState();
}

class _RecruiterJobPostState extends State<RecruiterJobPost> {
  User? user = FirebaseAuth.instance.currentUser;
  User? subuser = FirebaseAuth.instance.currentUser;
  model.JobPosted loggedinUser = model.JobPosted();

  void deleteNestedSubcollections(String id) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("jobs")
        .doc(id)
        .delete();
  }

  // removejob() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .collection("jobs")
  //       .doc()
  //       .delete();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Jobs Posted"),
          backgroundColor: AppColors.blueColor,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(user!.uid)
                .collection('jobs')
                .snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot jobs = snapshot.data!.docs[index];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jobs['jobtitle'],
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
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RecruiterJobUpdate(
                                                        user: model.JobPosted(
                                                            id: jobs['id'],
                                                            jobtitle: jobs[
                                                                'jobtitle'],
                                                            jobdes:
                                                                jobs['jobdes'],
                                                            jobtype: jobs[
                                                                'jobtype']))));
                                      },
                                      child: Container(
                                          width: 80,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.blueColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Edit",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        deleteNestedSubcollections(jobs['id']);
                                      },
                                      child: Container(
                                          width: 80,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.blueColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Remove",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Container(
                                          width: 80,
                                          height: 50,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              color: AppColors.blueColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text(
                                            "Applicants",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : CircularProgressIndicator();
            }));
  }
}
