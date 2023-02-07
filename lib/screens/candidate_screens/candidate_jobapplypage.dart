import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/screens/candidate_screens/quizz_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/buttons/rounded_back_button.dart';
import '../../components/utils/app_colors.dart';
import '../../components/utils/app_size.dart';

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
            SizedBox(height: 2.h),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButtonRounded(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.sp),
                  child: CustomText(
                      text: "Applicant's CV",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.primaryGrey),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  loggedinUser.pdfurl != null
                      ? Container(
                          width: double.infinity,
                          height: 100.sp,
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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: CustomButton(
                        text: "Continue",
                        onTap: () { 
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const QuizzScreen()));
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
