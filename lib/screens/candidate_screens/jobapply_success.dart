import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/homepage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/app_colors.dart';
import '../../components/utils/custom_router.dart';

class JobApplySuccess extends StatefulWidget {
  const JobApplySuccess({super.key});

  @override
  State<JobApplySuccess> createState() => _JobApplySuccessState();
}

class _JobApplySuccessState extends State<JobApplySuccess> {
  bool success = false;

  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          success = false;
        });
        CustomRouter().push(context, const CandidateHomePage());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundBlue,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/success.png",
                scale: 3,
              ),
            ),
            SizedBox(
              height: 15.sp,
            ),
            Text(
              "Your application successfully sent",
              style: TextStyle(
                  fontSize: 6.w,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryBlueSea),
            )
          ],
        ),
      ),
    );
  }
}
