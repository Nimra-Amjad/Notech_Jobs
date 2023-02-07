import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'candidate_screens/jobapply_success.dart';

class ResultScreen extends StatefulWidget {
  int score;
  ResultScreen(this.score, {Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
                text: "Your Score",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.quizbluecolor),
            SizedBox(
              height: 6.h,
            ),
            CustomText(
                text: "${widget.score}",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.quizbluecolor),
            SizedBox(
              height: 8.h,
            ),
            CustomButton(
              text: "Back To HomePage",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JobApplySuccess()));
              },
            )
          ],
        ),
      ),
    );
  }
}
