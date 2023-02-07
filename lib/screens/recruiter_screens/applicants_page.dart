import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/view_applicant_cv.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/app_colors.dart';
import '../../components/text/custom_text.dart';
import '../../components/buttons/rounded_back_button.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

class ApplicantsPage extends StatefulWidget {
  final String jobid;
  const ApplicantsPage({super.key, required this.jobid});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  model.JobPosted loggedinUser = model.JobPosted();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getapplicantsnames();
  }

  List applicantslist = [];

  void getapplicantsnames() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc(widget.jobid)
        .get()
        .then((value) {
      setState(() {
        applicantslist = value['applicants'];
      });
      print("0000000000000000000000");
      print(applicantslist);
      print("0000000000000000000000");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
              text: "Applicant's CVs",
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontColor: AppColors.primaryWhite),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: applicantslist.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.sp, vertical: 8.sp),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewApplicantsResume(
                                  filename: applicantslist[index]['pdfname'],
                                  fileurl: applicantslist[index]['pdfurl'])));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 7.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: AppColors.lightGrey),
                      child: CustomText(
                          text: applicantslist[index]['pdfname'],
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.primaryBlack),
                    ),
                  ),
                );
              }),
        ));
  }
}
