import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../text/custom_text.dart';
import '../utils/app_colors.dart';

class QuickSelectButton extends StatelessWidget {
  final String text;
  final double? width;
  final double? textsize;
  final Function() ontap;
  final Color? btncolor;
  final Color? textColor;
  const QuickSelectButton(
      {super.key,
      required this.text,
      required this.ontap,
      this.btncolor,
      this.textColor,
      this.width, this.textsize});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: SimpleShadow(
        offset: const Offset(1, 1),
        sigma: 5,
        color: AppColors.primaryBlack.withOpacity(0.4),
        child: Container(
          width: width ?? 18.w,
          height: 5.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: btncolor ?? AppColors.blueColor,
              borderRadius: BorderRadius.circular(25.0)),
          child: CustomText(
            fontSize: textsize??14.sp,
            text: text,
            fontColor: textColor ?? AppColors.primaryWhite,
          ),
        ),
      ),
    );
  }
}











 