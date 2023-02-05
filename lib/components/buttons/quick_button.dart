import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../text/custom_text.dart';
import '../utils/app_size.dart';

class QuickSelectButton extends StatelessWidget {
  final Function() onTap;
  final String? text;
  final double? width;
  final double? height;
  final Color? color;

  const QuickSelectButton({
    Key? key,
    required this.onTap,
    this.text,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? AppSize.buttonWidth / 4,
        height: height ?? AppSize.buttonHeight / 1.5,
        decoration: BoxDecoration(
          color: color ?? AppColors.blueColor,
          borderRadius: BorderRadius.circular(AppSize.fieldRadius),
        ),
        alignment: Alignment.center,
        child: CustomText(
          text: text ?? "Select",
          fontSize: AppSize.textSize * 1.1,
          fontWeight: FontWeight.bold,
          fontColor: AppColors.primaryWhite,
        ),
      ),
    );
  }
}
