import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_skills.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/utils/app_colors.dart';

class ResumeTitleScreen extends StatefulWidget {
  const ResumeTitleScreen({super.key});

  @override
  State<ResumeTitleScreen> createState() => _ResumeTitleScreenState();
}

class _ResumeTitleScreenState extends State<ResumeTitleScreen> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _resumeTitlecontroller = TextEditingController();

  final TextEditingController _yearsOfExperiencecontroller =
      TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _resumeTitlecontroller.dispose();
    _yearsOfExperiencecontroller.dispose();
  }

  addResumeTitle() async {
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "resumeTitle": _resumeTitlecontroller.text,
      "yearsOfExperience": int.parse(_yearsOfExperiencecontroller.text)
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResumeSkills()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Title"),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.paddingBottom,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.textboxfillcolor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: TextFormField(
                        controller: _resumeTitlecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        style:
                            TextStyle(color: AppColors.blueColor, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Resume Title*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.textboxfillcolor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: TextFormField(
                        controller: _yearsOfExperiencecontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        style:
                            TextStyle(color: AppColors.blueColor, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Years of experience*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  height: AppSize.paddingBottom * 3,
                ),
                CustomButton(
                    text: 'Next',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addResumeTitle();
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
