import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/text/custom_text.dart';
import '../../../components/utils/app_colors.dart';
import '../../../videocalling/videocall_screen.dart';

class CandidateInterviewsScreen extends StatefulWidget {
  const CandidateInterviewsScreen({super.key});

  @override
  State<CandidateInterviewsScreen> createState() =>
      _CandidateInterviewsScreenState();
}

class _CandidateInterviewsScreenState extends State<CandidateInterviewsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  List<dynamic> all_interviews = [];

  void getallinterviews() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      final interviews = value['interviews'];

      if (interviews != null && interviews is List<dynamic>) {
        setState(() {
          all_interviews = interviews;
        });
      } else {
        print('Interviews data is null or not of type List<dynamic>.');
      }
    }).catchError((error) {
      print('Error retrieving interviews: $error');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallinterviews();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'Interviews',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: ListView.builder(
            itemCount: all_interviews.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                              text: all_interviews[index]['date'],
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              fontColor: AppColors.blueColor),
                          CustomText(
                              text: " at ",
                              fontSize: 15.sp,
                              fontWeight: FontWeight.normal,
                              fontColor: AppColors.quizbluecolor),
                          CustomText(
                              text: all_interviews[index]['time'],
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              fontColor: AppColors.blueColor),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        children: [
                          CustomText(
                              text: "Job Title: ",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              fontColor: AppColors.primaryBlack),
                          CustomText(
                              text: all_interviews[index]['jobtitle'],
                              fontSize: 17.sp,
                              fontWeight: FontWeight.bold,
                              fontColor: AppColors.primaryBlack),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
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
                              // deleteNestedSubcollections(
                              //     jobs['id']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VideoCallingScreen()));
                            },
                            child: Container(
                                width: 80,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.blueLight,
                                    borderRadius: BorderRadius.circular(12)),
                                child: CustomText(
                                    text: "Join",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    fontColor: AppColors.primaryWhite)),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             AppliedCandidatesScreen(
                              //               job_id: jobs['id'],
                              //               job_name:
                              //                   jobs['jobtitle'],
                              //             )));
                            },
                            child: Container(
                                width: 80,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.blueLight,
                                    borderRadius: BorderRadius.circular(12)),
                                child: CustomText(
                                    text: "Remove",
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                    fontColor: AppColors.primaryWhite)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
