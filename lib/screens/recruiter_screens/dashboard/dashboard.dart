import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/jobs_applied_screen.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/applicants.dart/applied_candidates_screen.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/add_skill_screen.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/job_skills.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/interview_screen.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/posted_jobs/posted_jobs_screen.dart';

import '../../../components/buttons/quick_select_button.dart';
import '../../../components/utils/app_assets.dart';
import '../../login.dart';
import 'add_quiz/add_question.dart';
import 'company_profile_screen.dart';
import 'create_job/add_job_description.dart';

class RecruiterDashBoard extends StatefulWidget {
  const RecruiterDashBoard({super.key});

  @override
  State<RecruiterDashBoard> createState() => _RecruiterDashBoardState();
}

class _RecruiterDashBoardState extends State<RecruiterDashBoard> {
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.paddingBottom * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dashBoard(AppAssets.jobsdb, 'Jobs Posted', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostedJobsScreen()));
                    }),
                    _dashBoard(AppAssets.companyprofiledb, 'Company Profile',
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CompanyProfileScreen()));
                    })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _dashBoard(AppAssets.resumedb, 'Applied Candidates', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AppliedCandidatesScreen()));
                    }),
                    _dashBoard(AppAssets.createResumedb, 'Create Job', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddJobDescription()));
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
                                  RecruiterInterviewsScreen()));
                    }),
                    _dashBoard(AppAssets.jobsapplieddb, 'Add Quiz', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddQuestion()));
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
