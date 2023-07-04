import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';
import 'applied_candidates_screen.dart';

class CandidateDetailScreen extends StatefulWidget {
  final String job_id;
  final String candidate_name;
  final String candidate_email;
  final String candidate_mobilenumber;
  final int yearsofexp;
  final String resumetitle;
  final List<dynamic> resumeducation;
  final List<dynamic> resumexperience;
  final List<dynamic> resumskills;
  const CandidateDetailScreen(
      {super.key,
      required this.candidate_name,
      required this.yearsofexp,
      required this.resumetitle,
      required this.resumeducation,
      required this.resumexperience,
      required this.resumskills,
      required this.candidate_email,
      required this.candidate_mobilenumber,
      required this.job_id});

  @override
  State<CandidateDetailScreen> createState() => _CandidateDetailScreenState();
}

class _CandidateDetailScreenState extends State<CandidateDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AppliedCandidatesScreen(
                      job_id: widget.job_id,
                    )));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: '${widget.candidate_name}',
                      fontColor: AppColors.primaryWhite,
                    ),
                    CustomText(
                      text: '${widget.resumetitle}',
                      fontColor: AppColors.primaryWhite,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Contact Information",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    children: [
                      CustomText(text: '${widget.candidate_email}'),
                      CustomText(text: '${widget.candidate_mobilenumber}'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Skills",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.resumskills.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            CustomText(text: widget.resumskills[index])
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Education",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.resumeducation.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: widget.resumeducation[index]
                                          ['collegeName']),
                                  CustomText(
                                      text: widget.resumeducation[index]
                                          ['passingYear']),
                                  CustomText(
                                      text: widget.resumeducation[index]
                                          ['qualification']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Experience",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.resumexperience.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: widget.resumexperience[index]
                                        ['companyName']),
                                CustomText(
                                    text: widget.resumexperience[index]
                                        ['designation']),
                                CustomText(
                                    text: widget.resumexperience[index]
                                        ['joinDate']),
                                CustomText(
                                    text: widget.resumexperience[index]
                                        ['endDate']),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
