import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_education.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_experience.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_skills.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';

class ResumeEducation extends StatefulWidget {
  const ResumeEducation({super.key});

  @override
  State<ResumeEducation> createState() => _ResumeEducationState();
}

class _ResumeEducationState extends State<ResumeEducation> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passingYearcontroller = TextEditingController();
  final TextEditingController _collegeNamecontroller = TextEditingController();
  final TextEditingController _qualificationcontroller =
      TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _qualificationcontroller.dispose();
    _collegeNamecontroller.dispose();
    _passingYearcontroller.dispose();
  }

  ///<------------------------------Add Candidate Education to Database------------------------------>
  addeducation() async {
    model.Education edu = model.Education(
        qualification: _qualificationcontroller.text,
        passingYear: _passingYearcontroller.text,
        collegeName: _collegeNamecontroller.text);
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "educations": FieldValue.arrayUnion([edu.toJson()])
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddEducation()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResumeSkills()));
        return false;
      },
      child: WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddEducation()));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blueColor,
            title: CustomText(
              text: 'Add your Education',
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
                            _qualificationcontroller.text.trim().isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      controller: _qualificationcontroller,
                      autovalidateMode: AutovalidateMode.disabled,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppDecorations.customTextFieldDecoration(
                          hintText: "Qualification*"),
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
                            _passingYearcontroller.text.trim().isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      controller: _passingYearcontroller,
                      autovalidateMode: AutovalidateMode.disabled,
                      keyboardType: TextInputType.number,
                      decoration: AppDecorations.customTextFieldDecoration(
                          hintText: "Passing Year*"),
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
                            _collegeNamecontroller.text.trim().isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      controller: _collegeNamecontroller,
                      autovalidateMode: AutovalidateMode.disabled,
                      keyboardType: TextInputType.emailAddress,
                      decoration: AppDecorations.customTextFieldDecoration(
                          hintText: "School/College Name*"),
                    ),
                    SizedBox(
                      height: AppSize.paddingBottom * 5,
                    ),
                    CustomButton(
                        text: "Add Education",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addeducation();
                          }
                        }),
                    SizedBox(
                      height: 1.h,
                    ),
                    CustomButton(
                        text: "View Education",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddEducation()));
                        }),
                    SizedBox(
                      height: 1.h,
                    ),
                    CustomButton(
                      text: 'Next',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ResumeExperience()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
