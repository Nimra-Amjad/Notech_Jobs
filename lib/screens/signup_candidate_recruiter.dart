import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/signup.dart';
import 'package:notech_mobile_app/screens/login.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/signup.dart';

import '../components/utils/colors.dart';
import '../components/widgets/rounded_back_button.dart';
import '../components/widgets/textbutton.dart';

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
            "assets/images/signup.jpg",
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
        ],
      ),
    );
  }
}
