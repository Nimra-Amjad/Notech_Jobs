// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppSize {
  //~~~~~~~~~~~~~~~~~~~~~~~~~Screen Size~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  static MediaQueryData? _mediaQueryData;
  static late double getWidth;
  static late double getHeight;
  static late double appBarHeight;
  static late double screenWidth;
  static late double screenHeight;
  static late double imageHeight;
  static late double iconHeight;
  static late double imageWidth;
  static late double cardHeight;
  static late double cardWidth;
  static late double buttonHeight;
  static late double buttonWidth;
  static late double buttonFieldRadius;
  static late double fieldRadius;
  static late double barHeight;
  static late double bannerTextSize;
  static late double paddingAll;
  static late double paddingLeft;
  static late double paddingRight;
  static late double paddingTop;
  static late double paddingBottom;
  static late double borderRadius;
  static late double buttonBorderRadius;
  static late double headSize;
  static late double buttonTextSize;
  static late double textSize;
  static late double iconBgSize;
  static late double iconSize;
  static late double iconPadding;
  static late double tapPadding;
  static late double borderWidth;
  static late double circularImageRadius;
  static late double cardElevation;
  static late double contentPadding;
  static late double logoScale;

  static double? getScreenBasedSize({
    double? tabletSize,
    double? mobileSize,
    double? landscapeSize,
  }) {
    if (Device.screenType == ScreenType.tablet &&
        Device.orientation == Orientation.portrait) {
      print("${Device.screenType} ${Device.orientation}");
      return tabletSize ?? 20.sp;
    }
    if (Device.screenType == ScreenType.mobile) {
      print("${Device.screenType} ${Device.orientation}");
      return mobileSize ?? 20.sp;
    }
    if (Device.screenType == ScreenType.tablet &&
        Device.orientation == Orientation.landscape) {
      print("${Device.screenType} ${Device.orientation}");
      return landscapeSize ?? 20.sp;
    }
    return null;
  }

  static bool? isTablet() {
    if (Device.screenType == ScreenType.tablet) {
      return true;
    } else {
      return false;
    }
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    getWidth = _mediaQueryData!.size.width;
    getHeight = _mediaQueryData!.size.height;
    screenWidth = 100.w;
    screenHeight = 100.h;
    appBarHeight = 9.h;
    imageHeight = 30.h;
    imageWidth = 100.w;
    iconHeight = 5.sp;
    buttonHeight = 32.sp;
    cardHeight = 50.sp;
    cardWidth = 47.sp;
    buttonWidth = screenWidth;
    buttonFieldRadius = 50.sp;
    fieldRadius = 16.sp;
    barHeight = 7.h;
    bannerTextSize = 20.sp;
    contentPadding = 0.5.h;
    paddingAll = 15.sp;
    paddingLeft = 20.sp;
    paddingRight = 20.sp;
    paddingTop = 20.sp;
    paddingBottom = 20.sp;
    borderRadius = 5.w;
    buttonBorderRadius = 1.w * 1.h;
    headSize = 22.sp;
    buttonTextSize = 18.sp;
    textSize = 16.sp;
    iconBgSize = 30.sp;
    iconSize = 20.sp;
    iconPadding = 0.8.h;
    tapPadding = 5;
    borderWidth = 1;
    circularImageRadius = 100;
    cardElevation = 3;
    logoScale = screenWidth;
  }

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

}
