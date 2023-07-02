import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_title.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/utils/app_assets.dart';
import '../../../../components/utils/app_colors.dart';
import '../update_candidate_profile.dart';

class ResumeProfile extends StatefulWidget {
  const ResumeProfile({super.key});

  @override
  State<ResumeProfile> createState() => _ResumeProfileState();
}

class _ResumeProfileState extends State<ResumeProfile> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Candidate loggedinUser = model.Candidate();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  ///<------------------------------Get Loggedin User Data------------------------------>

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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CandidateDashboardScreen()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: AppSize.paddingBottom * 3),
                CircleAvatar(
                  backgroundImage: AssetImage(AppAssets.profiledb),
                  radius: 60,
                ),
                SizedBox(height: AppSize.paddingBottom * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Update Personal Information',
                      fontSize: 19.sp,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CandidateUpdatePage(
                                      text: "candidateresumeprofile",
                                      candidate: model.Candidate(
                                          username: loggedinUser.username,
                                          email: loggedinUser.email,
                                          mobileno: loggedinUser.mobileno))));
                        },
                        child: Icon(Icons.edit))
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.blueColor),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(text: "User Name:"),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(text: "Email:"),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(text: "Phone Number:"),
                          ],
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: '${loggedinUser.username}',
                              fontColor: AppColors.blueColor,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                              text: '${loggedinUser.email}',
                              fontColor: AppColors.blueColor,
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                              text: '${loggedinUser.mobileno}',
                              fontColor: AppColors.blueColor,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.paddingBottom * 4,
                ),
                CustomButton(
                  text: 'Next',
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResumeTitleScreen()));
                  },
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
