import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/widgets/custom_text.dart';
import 'package:notech_mobile_app/screens/candidate_screens/quizz_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/utils/colors.dart';

class CandidateJobApply extends StatefulWidget {
  const CandidateJobApply({super.key});

  @override
  State<CandidateJobApply> createState() => _CandidateJobApplyState();
}

class _CandidateJobApplyState extends State<CandidateJobApply> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Candidate loggedinUser = model.Candidate();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    // this.loggedinUser = model.Candidate.fromSnap(snap);
    setState(() {
      loggedinUser = model.Candidate.fromSnap(snap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              height: 40,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.arrow_back_ios),
                  )),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 12.sp),
                    child: CustomText(
                        text: "Applicant's CV",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.primaryGrey),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  loggedinUser.pdfurl != null
                      ? Container(
                          width: double.infinity,
                          height: 100.sp,
                          // decoration: BoxDecoration(color: Colors.amber),
                          child: SfPdfViewer.network('${loggedinUser.pdfurl}'),
                        )
                      : Container(
                          width: double.infinity,
                          height: 60.sp,
                          alignment: Alignment.center,
                          child: CustomText(
                              text: "Please Upload Your Resume",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontColor: AppColors.primaryBlack),
                        ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => QuizzScreen()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.blueColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
