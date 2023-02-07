import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notech_mobile_app/components/widgets/custom_icon.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/buttons/rounded_back_button.dart';
import '../../components/text/custom_text.dart';
import '../../components/theme/decorations.dart';
import '../../components/utils/app_colors.dart';
import '../../components/utils/app_size.dart';

class RecruiterAddJob extends StatefulWidget {
  const RecruiterAddJob({super.key});

  @override
  State<RecruiterAddJob> createState() => _RecruiterAddJobState();
}

class _RecruiterAddJobState extends State<RecruiterAddJob> {
  User? user = FirebaseAuth.instance.currentUser;
  List joblist = [];
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _jobtitlecontroller = TextEditingController();
  final TextEditingController _jobdescontroller = TextEditingController();
  final TextEditingController _jobtypecontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jobtitlecontroller.dispose();
    _jobdescontroller.dispose();
    _jobtypecontroller.dispose();
  }

  addjob() async {
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    //add user to our database
    model.JobPosted job = model.JobPosted(
      id: random,
      jobtitle: _jobtitlecontroller.text,
      jobdes: _jobdescontroller.text,
      jobtype: _jobtypecontroller.text,
      uid: user!.uid,
    );


//add jobs to firestore collection
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc(random)
        .set(job.toJson());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecruiterJobPost()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 2.h),
              Align(
                alignment: Alignment.centerLeft,
                child: BackButtonRounded(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(height: AppSize.paddingAll),
              CustomText(
                  textAlign: TextAlign.center,
                  text: "Add a Job",
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  fontColor: AppColors.blueColor),
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 6.h,
                      ),
                      CustomText(
                          text: "Job Title : ",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.primaryBlack),
                      SizedBox(height: AppSize.paddingAll),
                      TextFormField(
                        cursorHeight: AppSize.textSize * 1.2,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: AppSize.textSize * 1.2,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        controller: _jobtitlecontroller,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppDecorations.customTextFieldDecoration(
                            prefixIcon: CustomIcon(
                                icon: Icons.work_outline,
                                iconColor: AppColors.blueColor),
                            hintText: "Job Title"),
                      ),
                      SizedBox(height: AppSize.paddingAll),
                      CustomText(
                          text: "Job Description : ",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.primaryBlack),
                      SizedBox(height: AppSize.paddingAll),
                      TextFormField(
                        cursorHeight: AppSize.textSize * 1.2,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: AppSize.textSize * 1.2,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        controller: _jobdescontroller,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppDecorations.customTextFieldDecoration(
                            prefixIcon: CustomIcon(
                                icon: Icons.work_outline,
                                iconColor: AppColors.blueColor),
                            hintText: "Job Description"),
                      ),
                      SizedBox(height: AppSize.paddingAll),
                      CustomText(
                          text: "Job Type : ",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.primaryBlack),
                      SizedBox(height: AppSize.paddingAll),
                      TextFormField(
                        cursorHeight: AppSize.textSize * 1.2,
                        style: TextStyle(
                          color: AppColors.primaryBlack,
                          fontSize: AppSize.textSize * 1.2,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        controller: _jobtypecontroller,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppDecorations.customTextFieldDecoration(
                            prefixIcon: CustomIcon(
                                icon: Icons.work_outline,
                                iconColor: AppColors.blueColor),
                            hintText: "Job Type"),
                      ),
                      SizedBox(height: 10.h),
                      CustomButton(
                          text: "Save",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              addjob();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
