import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_education.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Education loggedinUser = model.Education();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcandidateEducation();
  }

  List educationlist = [];

  //<---------------------------------Get Candidate Education--------------------------------------------->

  void getcandidateEducation() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        educationlist = value['educations'];
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
            itemCount: educationlist.length,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: educationlist[index]['qualification'],
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryGrey),
                                CustomText(
                                    text: educationlist[index]['passingYear'],
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryBlack),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                                text: educationlist[index]['collegeName'],
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.primaryBlack),
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
              MaterialPageRoute(builder: (context) => ResumeEducation()));
        },
      ),
    );
  }
}
