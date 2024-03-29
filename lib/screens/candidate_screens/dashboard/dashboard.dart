import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_title.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/interviews_screen.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/jobs_applied_screen.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/candidate_profile_screen.dart';

import '../../../components/buttons/quick_select_button.dart';
import '../../../components/utils/app_assets.dart';
import '../../login.dart';
import 'candidate_resume_screen.dart';
import 'create_resume/resume_profile.dart';
import 'jobs_screens/jobs_screen.dart';

class CandidateDashboardScreen extends StatefulWidget {
  const CandidateDashboardScreen({super.key});

  @override
  State<CandidateDashboardScreen> createState() =>
      _CandidateDashboardScreenState();
}

class _CandidateDashboardScreenState extends State<CandidateDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: CustomText(
          text: "Candidate Dashboard",
          fontColor: AppColors.primaryWhite,
        ),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.paddingBottom * 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dashBoard(AppAssets.jobsdb, 'Jobs', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsScreen()));
                    }),
                    _dashBoard(AppAssets.profiledb, 'Profile', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateProfileScreen()));
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dashBoard(AppAssets.resumedb, 'Candidate Resume', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateResumeScreen()));
                    }),
                    _dashBoard(AppAssets.createResumedb, 'Create Resume', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ResumeProfile()));
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dashBoard(AppAssets.interviewdb, 'Interviews', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CandidateInterviewsScreen()));
                    }),
                    _dashBoard(AppAssets.jobsapplieddb, 'Jobs Applied', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobsAppliedScreen()));
                    })
                  ],
                ),
                _dashBoard(AppAssets.logoutdb, 'LogOut', () {
                  _alert();
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  _dashBoard(image, name, funtion) {
    return InkWell(
      onTap: funtion,
      child: Container(
        padding: EdgeInsets.all(10),
        width: 170,
        margin: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.blueColor.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Image.asset(
              image,
              height: 70,
              width: 70,
            ),
            SizedBox(height: 15),
            Text(
              name,
              style: TextStyle(color: AppColors.primaryBlack, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  _alert() {
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
                    'Are you sure you want to Logout?',
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage()));
                          })
                    ],
                  )
                ],
              ));
        });
  }
}
