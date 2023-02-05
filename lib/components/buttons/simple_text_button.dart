import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';

class SimpleTextButton extends StatelessWidget {
  final String text;
  final Color? textColor, templateColor;
  final dynamic function;
  final double? buttonSize;
  const SimpleTextButton(
      {Key? key,
      required this.text,
      this.textColor,
      this.templateColor,
      this.buttonSize,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          fixedSize:
              MaterialStateProperty.all(Size.fromHeight(buttonSize ?? 0)),
          backgroundColor: MaterialStateProperty.all(
              templateColor ?? AppColors.blueColor)),
      child: CustomText(
          text: text,
          fontSize: AppSize.textSize * 1.2,
          fontWeight: FontWeight.w700,
          fontColor: textColor ?? AppColors.primaryWhite),
      onPressed: (() => function()),
    );
  }
}
