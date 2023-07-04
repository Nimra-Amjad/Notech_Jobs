import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/edit_experience.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_experience.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/buttons/quick_select_button.dart';
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

  //<---------------------------------Get Candidate Experience--------------------------------------------->
  List experiencelist = [];
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

  //<---------------------------------Remove Candidate Skills--------------------------------------------->
  Future<void> removeElementFromList(int index) async {
    try {
      setState(() {
        experiencelist.removeAt(index);
        print(experiencelist);
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"experience": experiencelist});
    } catch (error) {
      print('Error removing element from list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResumeExperience()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'Your Experience',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: experiencelist.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> experience = experiencelist[index];
                String companyName = experience['companyName'];
                String designation = experience['designation'];
                String joinDate = experience['joinDate'];
                String endDate = experience['endDate'];
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
                                  text: designation,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.primaryGrey),
                              SizedBox(
                                height: 1.h,
                              ),
                              CustomText(
                                  text: companyName,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.primaryBlack),
                              SizedBox(
                                height: 1.h,
                              ),
                              Row(
                                children: [
                                  CustomText(
                                      text: joinDate,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontColor: AppColors.primaryBlack),
                                  CustomText(
                                      text: '-',
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontColor: AppColors.primaryBlack),
                                  CustomText(
                                      text: endDate,
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
                          GestureDetector(onTap: () {Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditResumeExperience(
                                                    candidate: experience,
                                                    index: index,
                                                  )));}, child: Icon(Icons.edit)),
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
                MaterialPageRoute(builder: (context) => ResumeExperience()));
          },
        ),
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
