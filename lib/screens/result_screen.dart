import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
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
            // Text(
            //   "You Score is",
            //   style: TextStyle(color: AppColors.quizbluecolor, fontSize: 34.0),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
            // Text(
            //   "${widget.score}",
            //   style: TextStyle(
            //     color: Colors.orange,
            //     fontSize: 85.0,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            // SizedBox(
            //   height: 20.0,
            // ),
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
