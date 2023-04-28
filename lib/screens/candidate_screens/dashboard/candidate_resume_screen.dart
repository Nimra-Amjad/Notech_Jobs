import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_assets.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
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
    return Scaffold(
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
              child: CustomText(
                text: '${loggedinUser.username}',
                fontColor: AppColors.primaryWhite,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            CustomText(
              text: "Skills",
              fontWeight: FontWeight.normal,
              fontColor: AppColors.primaryBlueSea,
              fontSize: 20.sp,
            ),
            Divider(
              color: AppColors.primaryBlueSea,
            ),
            ListView.builder(
                itemCount: candidateSkills.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Row(
                      children: [
                        Icon(Icons.check),
                        CustomText(text: candidateSkills[index])
                      ],
                    ),
                  );
                })
          ],
        ),
      )),
    );
  }
}
