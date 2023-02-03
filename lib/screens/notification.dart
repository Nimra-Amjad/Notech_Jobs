import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/utils/colors.dart';
import '../components/widgets/custom_text.dart';
import '../components/widgets/rounded_back_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(color: Colors.white),
      backgroundColor: AppColors.gradientcolor1,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: Padding(
                  padding: EdgeInsets.all(18.sp),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: BackButtonRounded(
                          color: AppColors.primaryWhite,
                          iconcolor: AppColors.primaryBlack,
                          bordercolor: AppColors.primaryGrey,
                        ),
                      ),
                      SizedBox(
                        width: 35.sp,
                      ),
                      CustomText(
                          text: "Notifications",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          fontColor: AppColors.primaryBlack),
                    ],
                  )),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.primaryWhite,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30.0),
                        topLeft: Radius.circular(30.0))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                        text: "No notifications",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontColor: AppColors.primaryBlack),
                    SizedBox(
                      height: 15.sp,
                    ),
                    CustomText(
                        text: "You have no notification at this time",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        fontColor: AppColors.primaryBlack),
                    SizedBox(
                      height: 8.sp,
                    ),
                    CustomText(
                        text: "thank you",
                        fontSize: 15.sp,
                        fontWeight: FontWeight.normal,
                        fontColor: AppColors.primaryBlack),
                    SizedBox(
                      height: 15.sp,
                    ),
                    SvgPicture.asset("assets/images/notification.svg"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
