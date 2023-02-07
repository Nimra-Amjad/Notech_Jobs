import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/signup.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/signup.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/utils/app_assets.dart';
import '../components/buttons/rounded_back_button.dart';
import '../components/buttons/textbutton.dart';
import '../components/utils/app_size.dart';

class SignupCandidateRecruiter extends StatefulWidget {
  const SignupCandidateRecruiter({super.key});

  @override
  State<SignupCandidateRecruiter> createState() =>
      _SignupCandidateRecruiterState();
}

class _SignupCandidateRecruiterState extends State<SignupCandidateRecruiter> {
  void navigateToCandidateSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const CandidateSignUpPage()));
  }

  void navigateToRecruiterSignUp() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RecruiterSignUpPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppAssets.background),
                  scale: 1,
                  fit: BoxFit.fill)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: AppSize.paddingAll),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButtonRounded(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: AppSize.paddingAll),
                Image.asset(AppAssets.rcSignup, scale: 1, fit: BoxFit.fill),
                TextButtonWidget(
                    onpressed: navigateToCandidateSignUp,
                    text: "Signup as Candidate",
                    width: 80.w,
                    height: 7.h),
                SizedBox(height: AppSize.paddingAll),
                TextButtonWidget(
                    onpressed: navigateToRecruiterSignUp,
                    text: "Signup as Recruiter",
                    width: 80.w,
                    height: 7.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
