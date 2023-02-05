import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? buttonColor;
  final Color? textColor;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.buttonColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return GestureDetector(
      onTap: onTap,
      child: SimpleShadow(
        offset: const Offset(1, 1),
        sigma: 5,
        color: AppColors.primaryBlack.withOpacity(0.4),
        child: Container(
          height: AppSize.buttonHeight,
          decoration: BoxDecoration(
            color: buttonColor ?? AppColors.blueColor,
            borderRadius: BorderRadius.circular(AppSize.buttonFieldRadius),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: AppSize.buttonTextSize,
                color: textColor ?? AppColors.primaryWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
