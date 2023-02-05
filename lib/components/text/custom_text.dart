import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double? fontSize;
  final String text;
  final FontWeight? fontWeight;
  final Color? fontColor;
  final TextAlign? textAlign;

  const CustomText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.fontColor,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
      ),
    );
  }
}
