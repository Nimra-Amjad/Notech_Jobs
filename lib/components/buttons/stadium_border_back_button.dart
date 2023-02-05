import 'dart:core';

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class LeftTopBackButton extends StatelessWidget {
  const LeftTopBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: AppSize.paddingTop + 30),
        child: SimpleShadow(
          color: AppColors.primaryBlack.withOpacity(0.3),
          sigma: 5,
          offset: const Offset(1, 1),
          child: Container(
            width: 50.w,
            height: 15.h,
            decoration: BoxDecoration(
              color: AppColors.primaryBlack,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back,
              color: AppColors.primaryBlack,
              size: AppSize.iconSize,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
