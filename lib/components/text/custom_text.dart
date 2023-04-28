import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomText extends StatelessWidget {
  final double? fontSize;
  final String text;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
    this.fontColor,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize ?? 17.sp,
        fontWeight: fontWeight ?? FontWeight.bold,
        color: fontColor ?? AppColors.primaryBlack,
      ),
    );
  }
}
