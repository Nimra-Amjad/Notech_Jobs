import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_education.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/buttons/quick_select_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';
import 'edit_education.dart';

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

  //<---------------------------------Get Candidate Education--------------------------------------------->
  List educationlist = [];
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

  //<---------------------------------Remove Candidate Skills--------------------------------------------->
  Future<void> removeElementFromList(int index) async {
    try {
      setState(() {
        educationlist.removeAt(index);
        print(educationlist);
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"educations": educationlist});
    } catch (error) {
      print('Error removing element from list: $error');
    }
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
              Map<String, dynamic> education = educationlist[index];
              String qualification = education['qualification'];
              String passingYear = education['passingYear'];
              String collegeName = education['collegeName'];
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
                                    text: qualification,
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryGrey),
                                CustomText(
                                    text: passingYear,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    fontColor: AppColors.primaryBlack),
                              ],
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            CustomText(
                                text: collegeName,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                fontColor: AppColors.primaryBlack),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditResumeEducation(
                                          candidate: education,index: index,)));
                            },
                            child: Icon(Icons.edit)),
                        SizedBox(
                          height: 1.h,
                        ),
                        GestureDetector(
                            onTap: () {
                              _alert(index);
                            },
                            child: Icon(Icons.delete))
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

  _alert(int index) {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              // insetPadding: EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Are you sure you want to remove?',
                    // maxLines: 2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      QuickSelectButton(
                        text: 'No',
                        ontap: () {
                          Navigator.pop(context);
                        },
                        btncolor: AppColors.primaryWhite,
                        textColor: AppColors.blueColor,
                      ),
                      QuickSelectButton(
                          text: 'Yes',
                          ontap: () {
                            removeElementFromList(index);
                            Navigator.pop(context);
                          })
                    ],
                  )
                ],
              ));
        });
  }
}
