import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_experience.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key});

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Experience loggedinUser = model.Experience();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcandidateExperience();
  }

  List experiencelist = [];

  //<---------------------------------Get Candidate Experience--------------------------------------------->

  void getcandidateExperience() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        experiencelist = value['experience'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Your Education',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: experiencelist.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(color: AppColors.lightGrey)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.sp, vertical: 14.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                                text: experiencelist[index]['designation'],
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.primaryGrey),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                                text: experiencelist[index]['companyName'],
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.primaryBlack),
                            SizedBox(
                              height: 1.h,
                            ),
                            Row(
                              children: [
                                CustomText(
                                    text: experiencelist[index]['joinDate'],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryBlack),
                                CustomText(
                                    text: '-',
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryBlack),
                                CustomText(
                                    text: experiencelist[index]['endDate'],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryBlack),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Icon(Icons.edit),
                        SizedBox(
                          height: 1.h,
                        ),
                        Icon(Icons.delete)
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
      bottomNavigationBar: CustomButton(
        text: 'Back',
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ResumeExperience()));
        },
      ),
    );
  }
}
