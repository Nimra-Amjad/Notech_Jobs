import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/recruiter_screens/applicants_page.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_update_job.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/app_colors.dart';

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
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.sp),
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(14.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: jobs['jobtitle'],
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.blueColor),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  CustomText(
                                      text: jobs['jobdes'],
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.normal,
                                      fontColor: AppColors.quizbluecolor),
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
                                                              jobdes: jobs[
                                                                  'jobdes'],
                                                              jobtype: jobs[
                                                                  'jobtype']))));
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.blueLight,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: CustomText(
                                                text: "Edit",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal,
                                                fontColor:
                                                    AppColors.primaryWhite)),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          deleteNestedSubcollections(
                                              jobs['id']);
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.blueLight,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: CustomText(
                                                text: "Remove",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal,
                                                fontColor:
                                                    AppColors.primaryWhite)),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ApplicantsPage(
                                                          jobid: jobs['id'])));
                                        },
                                        child: Container(
                                            width: 80,
                                            height: 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: AppColors.blueLight,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: CustomText(
                                                text: "Applicants",
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.normal,
                                                fontColor:
                                                    AppColors.primaryWhite)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : const CircularProgressIndicator();
            }));
  }
}
