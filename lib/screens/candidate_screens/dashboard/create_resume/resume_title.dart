import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_skills.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
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

  ///<------------------------------Get Loggedin User Data------------------------------>
  model.Candidate loggedinUser = model.Candidate();
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
            child: (loggedinUser.resumeTitle == null &&
                    loggedinUser.yearsOfExperience == null)
                ? Column(
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
                              style: TextStyle(
                                  color: AppColors.blueColor, fontSize: 20),
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
                              style: TextStyle(
                                  color: AppColors.blueColor, fontSize: 20),
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
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        SizedBox(
                          height: AppSize.paddingAll,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  border:
                                      Border.all(color: AppColors.lightGrey)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15.sp, vertical: 14.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Resume Title:",
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.primaryBlack,
                                      fontSize: 20.sp,
                                    ),
                                    SizedBox(
                                      height: AppSize.paddingAll,
                                    ),
                                    CustomText(
                                      text: "${loggedinUser.resumeTitle}",
                                      fontColor: AppColors.blueColor,
                                      fontSize: 18.sp,
                                    ),
                                    SizedBox(
                                      height: AppSize.paddingAll,
                                    ),
                                    CustomText(
                                      text: "Total Years of Experience:",
                                      fontWeight: FontWeight.bold,
                                      fontColor: AppColors.primaryBlack,
                                      fontSize: 20.sp,
                                    ),
                                    SizedBox(
                                      height: AppSize.paddingAll,
                                    ),
                                    CustomText(
                                      text: "${loggedinUser.yearsOfExperience}",
                                      fontColor: AppColors.blueColor,
                                      fontSize: 18.sp,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Icon(Icons.edit),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Icon(Icons.delete)
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: AppSize.paddingBottom * 3,
                        ),
                        CustomButton(
                            text: 'Next',
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ResumeSkills()));
                            })
                      ]),
          ),
        ),
      )),
    );
  }
}
