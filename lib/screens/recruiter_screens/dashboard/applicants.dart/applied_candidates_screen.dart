import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/applicants.dart/schedule_interview/schedule_interview.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';

class AppliedCandidatesScreen extends StatefulWidget {
  final String? job_id;
  final String? job_name;
  const AppliedCandidatesScreen({super.key, this.job_id, this.job_name});

  @override
  State<AppliedCandidatesScreen> createState() =>
      _AppliedCandidatesScreenState();
}

class _AppliedCandidatesScreenState extends State<AppliedCandidatesScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    getAllJobs();
    // getdata();
  }

  List<String> topUniversities = [
    "kIET",
    "NUST",
    "FAST",
    "NED",
    "DAWOOD",
    "ILMA",
    "KITE"
  ];

  model.Candidate loggedinUser = model.Candidate();
  List<dynamic> matching_skills = [];
  List<dynamic> job_match = [];

  //<---------------------------------Get All Jobs--------------------------------------------->
  // List<dynamic> selectedApplicants = [];
  // List<dynamic> allApplicants = [];
  // List<dynamic> allRequiredSkills = [];
  // String? userID;
  // int yearsRequired = 0;
  // Future<void> getAllJobs() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .collection("jobs")
  //       .doc(widget.job_id)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       allApplicants = value['applicants'];
  //       yearsRequired = value['yearsrequired'];
  //       allRequiredSkills = value['skills'];
  //       // userID = value['userid'];

  //       for (var applicant in allApplicants) {
  //         List<dynamic> applicantSkills = applicant['candidate_skills'];
  //         int canyears = applicant['yearsOfExperience'];
  //         bool hasMatchedSkills = false;

  //         for (var requiredSkill in allRequiredSkills) {
  //           if (applicantSkills.contains(requiredSkill) &&
  //               canyears >= yearsRequired)
  //               {
  //             selectedApplicants.add(applicant['candidate_name']);
  //           } else if (topUniversities.contains(applicant['university'])) {
  //             // Check if the candidate meets the years of experience requirement
  //             // if (canyears >= yearsRequired ||
  //             //     (canyears >= yearsRequired - 1 && canyears < yearsRequired)) {
  //             //   selectedApplicants.add(applicant['candidate_name']);
  //             // }
  //           }
  //           hasMatchedSkills = true;
  //           print(selectedApplicants.toList());
  //           break;
  //         }
  //         if (hasMatchedSkills) {
  //           // Applicant has all required skills
  //           print(
  //               'Applicant ${applicant['candidate_name']} has matched at least one of the required skills');
  //         } else {
  //           // Applicant does not have all required skills
  //           print(
  //               'Applicant ${applicant['candidate_name']} does not have any of the required skills');
  //         }
  //       }
  //     });
  //   });
  // }

  List<dynamic> selectedApplicants = [];
  List<dynamic> allApplicants = [];
  List<dynamic> allRequiredSkills = [];
  String? userID;
  int yearsRequired = 0;

  Future<void> getAllJobs() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc(widget.job_id)
        .get()
        .then((value) {
      setState(() {
        allApplicants = value['applicants'];
        yearsRequired = value['yearsrequired'];
        allRequiredSkills = value['skills'];
        // userID = value['userid'];

        for (var applicant in allApplicants) {
          List<dynamic> applicantSkills = applicant['candidate_skills'];
          int canYears = applicant['yearsOfExperience'];
          bool hasMatchedSkills = false;

          for (var requiredSkill in allRequiredSkills) {
            if (applicantSkills.contains(requiredSkill) &&
                canYears >= yearsRequired) {
              selectedApplicants.add(applicant['candidate_name']);
              hasMatchedSkills = true;
              break;
            }
          }

          if (hasMatchedSkills) {
            print(
                'Applicant ${applicant['candidate_name']} has matched at least one of the required skills');
          } else {
            print(
                'Applicant ${applicant['candidate_name']} does not have any of the required skills');
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Applied Candidates',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.paddingAll,
            ),
            TextFormField(
              cursorHeight: AppSize.textSize * 1.2,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: AppSize.textSize * 1.2,
              ),
              cursorColor: AppColors.blueColor,
              controller: _searchcontroller,
              autovalidateMode: AutovalidateMode.disabled,
              keyboardType: TextInputType.emailAddress,
              decoration: AppDecorations.customTextFieldDecoration(
                  hintText: "Search Candidate"),
            ),
            SizedBox(
              height: AppSize.paddingAll,
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: selectedApplicants.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: selectedApplicants[index],
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    fontColor: AppColors.blueColor),
                                const Divider(
                                  thickness: 0.5,
                                  height: 20.0,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ScheduleInterview(
                                                  job_id: widget.job_id,
                                                  appl_id: allApplicants[index]
                                                      ['userid'],
                                                  appl_name:
                                                      allApplicants[index]
                                                          ['candidate_name'],
                                                  job_title: widget.job_name,
                                                )));
                                  },
                                  child: Container(
                                      width: 140,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.blueLight,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: CustomText(
                                          text: "Schedule Interview",
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.normal,
                                          fontColor: AppColors.primaryWhite)),
                                )
                              ]),
                        ),
                      );
                    }))
          ],
        ),
      )),
    );
  }
}
