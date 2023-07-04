import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_assets.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CandidateResumeScreen extends StatefulWidget {
  const CandidateResumeScreen({super.key});

  @override
  State<CandidateResumeScreen> createState() => _CandidateResumeScreenState();
}

class _CandidateResumeScreenState extends State<CandidateResumeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  model.Candidate loggedinUser = model.Candidate();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
    getallSkills();
    getcandidateEducation();
    getcandidateExperience();
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

  //<---------------------------------Get Candidate Skills--------------------------------------------->
  List candidateSkills = [];
  void getallSkills() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        candidateSkills = value['skills'];
      });
      print(candidateSkills);
    });
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CandidateDashboardScreen()));
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                  color: AppColors.blueColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: '${loggedinUser.username}',
                      fontColor: AppColors.primaryWhite,
                    ),
                    CustomText(
                      text: '${loggedinUser.resumeTitle}',
                      fontColor: AppColors.primaryWhite,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Contact Information",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    children: [
                      CustomText(text: '${loggedinUser.email}'),
                      CustomText(text: '${loggedinUser.mobileno}'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Skills",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: candidateSkills.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            CustomText(text: candidateSkills[index])
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Education",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: educationlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.check),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                      text: educationlist[index]
                                          ['collegeName']),
                                  CustomText(
                                      text: educationlist[index]
                                          ['passingYear']),
                                  CustomText(
                                      text: educationlist[index]
                                          ['qualification']),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              CustomText(
                text: "Experience",
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlueSea,
                fontSize: 20.sp,
              ),
              Divider(
                color: AppColors.primaryBlueSea,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: experiencelist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.check),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: experiencelist[index]['companyName']),
                                CustomText(
                                    text: experiencelist[index]['designation']),
                                CustomText(
                                    text: experiencelist[index]['joinDate']),
                                CustomText(
                                    text: experiencelist[index]['endDate']),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
