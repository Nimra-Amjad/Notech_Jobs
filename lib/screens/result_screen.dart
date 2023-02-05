import 'package:flutter/material.dart';
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
            GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => JobApplySuccess()));
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.sp),
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors.quizbluecolor,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Back To HomePage",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}