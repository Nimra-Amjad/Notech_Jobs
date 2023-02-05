import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utils/app_colors.dart';
import '../utils/app_icons.dart';

class BackButtonRounded extends StatelessWidget {
  final Function()? onTap;
  final Color color;
  final Color iconcolor;
  final Color bordercolor;

  const BackButtonRounded({
    Key? key,
    this.onTap,
    this.color = AppColors.primaryBlack,
    this.iconcolor = AppColors.primaryWhite,
    this.bordercolor = AppColors.primaryBlack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10.sp, left: 16.sp),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: bordercolor),
          ),
          child: Icon(
            AppIcons.backArrowIcon,
            color: AppColors.primaryBlack,
          ),
        ),
      ),
    );
  }
}
