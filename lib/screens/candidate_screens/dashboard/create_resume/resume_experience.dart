import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/candidate_resume_screen.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_experience.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_education.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';

class ResumeExperience extends StatefulWidget {
  const ResumeExperience({super.key});

  @override
  State<ResumeExperience> createState() => _ResumeExperienceState();
}

class _ResumeExperienceState extends State<ResumeExperience> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNamecontroller = TextEditingController();
  final TextEditingController _designationcontroller = TextEditingController();
  final TextEditingController _joinDatecontroller = TextEditingController();
  final TextEditingController _endDatecontroller = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _endDatecontroller.dispose();
    _joinDatecontroller.dispose();
    _designationcontroller.dispose();
    _companyNamecontroller.dispose();
  }

  ///<------------------------------Add Candidate Education to Database------------------------------>
  addexperience() async {
    model.Experience exp = model.Experience(
        companyName: _companyNamecontroller.text,
        designation: _designationcontroller.text,
        joinDate: _joinDatecontroller.text,
        endDate: _endDatecontroller.text);
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "experience": FieldValue.arrayUnion([exp.toJson()])
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddExperience()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResumeEducation()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'Add your Experience',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.paddingBottom,
                  ),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          _companyNamecontroller.text.trim().isEmpty) {
                        return "* Required";
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _companyNamecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Company Name*"),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          _designationcontroller.text.trim().isEmpty) {
                        return "* Required";
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _designationcontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Designation*"),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          _joinDatecontroller.text.trim().isEmpty) {
                        return "* Required";
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _joinDatecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Joining Date*"),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          _endDatecontroller.text.trim().isEmpty) {
                        return "* Required";
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _endDatecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "End Date*"),
                  ),
                  SizedBox(
                    height: AppSize.paddingBottom * 5,
                  ),
                  CustomButton(
                      text: "Add Experience",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addexperience();
                        }
                      }),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomButton(
                      text: "View Experience",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddExperience()));
                      }),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomButton(
                    text: 'View Resume',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateResumeScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
