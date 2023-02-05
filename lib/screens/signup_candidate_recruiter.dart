import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/signup.dart';
import 'package:notech_mobile_app/screens/login.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/signup.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/buttons/simple_text_button.dart';
import '../components/utils/app_assets.dart';
import '../components/utils/app_colors.dart';
import '../components/buttons/rounded_back_button.dart';
import '../components/buttons/textbutton.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: ListTile(
            leading: BackButtonRounded(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
          color: AppColors.primaryWhite,
          bordercolor: AppColors.primaryBlack,
          iconcolor: AppColors.primaryBlack,
        )),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Image.asset(
            AppAssets.rcSignup,
            width: 100.w,
            height: 40.h,
          ),
          TextButtonWidget(
              onpressed: navigateToCandidateSignUp,
              text: "Signup as Candidate",
              width: 260,
              height: 60),
          TextButtonWidget(
              onpressed: navigateToRecruiterSignUp,
              text: "Signup as Recruiter",
              width: 260,
              height: 60),
        ],
      ),
    );
  }
}
