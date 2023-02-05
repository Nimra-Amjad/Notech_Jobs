import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';
import '../widgets/custom_icon.dart';

class AppDecorations {
  static InputDecoration customTextFieldDecoration(
      {String? hintText, Widget? prefixIcon, Widget? prefix, Widget? suffixIcon}) {
    return InputDecoration(
      contentPadding:
          EdgeInsets.only(top: AppSize.paddingAll, bottom: AppSize.paddingAll),
      fillColor: AppColors.textboxfillcolor,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.textboxfillcolor),
        borderRadius: BorderRadius.circular(AppSize.buttonFieldRadius),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.buttonFieldRadius),
        borderSide: BorderSide(color: AppColors.blueColor),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.buttonFieldRadius),
        borderSide: BorderSide(
          color: AppColors.blueColor,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSize.buttonFieldRadius),
        borderSide: BorderSide(
          color: AppColors.blueColor,
        ),
      ),
      hintText: hintText,
      
      isDense: true,
      prefix: prefix ??
          Padding(
            padding: EdgeInsets.only(left: AppSize.paddingAll),
            child: const CustomIcon(
              icon: Icons.visibility,
              iconColor: AppColors.transparent,
              iconSize: 0.1,
            ),
          ),
      prefixIcon: prefixIcon ??
          Padding(
            padding: EdgeInsets.only(left: AppSize.paddingAll),
            child: CustomIcon(
              icon: Icons.email_outlined,
              iconColor: AppColors.blueColor,
              iconSize: AppSize.iconSize,
            ),
          ),
      suffixIcon: suffixIcon ??
          Padding(
            padding: EdgeInsets.only(left: AppSize.paddingAll),
            child: CustomIcon(
              icon: Icons.visibility,
              iconColor: AppColors.transparent,
              iconSize: AppSize.iconSize,
            ),
          ),
      filled: true,
      labelStyle: TextStyle(
        color: AppColors.blueColor,
        fontSize: AppSize.textSize * 1.2,
      ),
    );
  }

  static BoxDecoration payDecoration() {
    return BoxDecoration(
      border: Border.all(color: AppColors.primaryBlack, width: 1.0),
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(40.0),
        bottomRight: Radius.circular(40.0),
        topLeft: Radius.circular(40.0),
        bottomLeft: Radius.circular(40.0),
      ),
    );
  }
}
