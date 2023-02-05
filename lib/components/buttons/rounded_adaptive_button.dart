import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../text/custom_text.dart';
import '../utils/app_colors.dart';

class RoundedAdaptiveButton extends StatelessWidget {
  final Function() onTap;
  final String title;
  final Color? buttonColor;
  final Color? fontColor;

  const RoundedAdaptiveButton({
    Key? key,
    required this.onTap,
    required this.title,
    this.buttonColor,
    this.fontColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SimpleShadow(
        color: AppColors.primaryBlack.withOpacity(0.5),
        sigma: 5,
        child: Container(
          padding: EdgeInsets.only(
            right: 25.sp,
            left: 25.sp,
            top: 18.sp,
            bottom: 18.sp,
          ),
          decoration: BoxDecoration(
            color: buttonColor ?? AppColors.blueColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: CustomText(
            text: title,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            fontColor: fontColor ?? AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}
