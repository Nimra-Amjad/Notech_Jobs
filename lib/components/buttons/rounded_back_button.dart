import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/app_colors.dart';

class BackButtonRounded extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color iconcolor;
  final Color bordercolor;

  const BackButtonRounded({
    Key? key,
    this.onTap,
    this.color = AppColors.primaryWhite,
    this.iconcolor = AppColors.primaryBlack,
    this.bordercolor = AppColors.primaryBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, left: 16.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 10.w,
          height: 5.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: bordercolor),
          ),
          child: Icon(
            Icons.arrow_back,
            color: AppColors.primaryBlack,
          ),
        ),
      ),
    );
  }
}
