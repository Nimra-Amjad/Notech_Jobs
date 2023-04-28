import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class CustomTextFormField extends StatelessWidget {
  final String hinttext;
  final String labeltext;
  final TextEditingController controller;
  final bool? obsecuretext;
  final IconData? suffixicon;
  final IconData? prefixicon;
  final Color? fillcolor;
  final TextInputType? keyboardtype;
  final Function()? ontapSuffixicon;
  const CustomTextFormField(
      {super.key,
      required this.hinttext,
      required this.controller,
      this.obsecuretext,
      this.suffixicon,
      this.prefixicon,
      this.ontapSuffixicon,
      required this.labeltext,
      this.fillcolor,
      this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardtype ?? TextInputType.text,
      obscureText: obsecuretext ?? false,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillcolor ?? AppColors.lightGrey,
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(20.0)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(20.0)),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.transparent),
            borderRadius: BorderRadius.circular(20.0)),
        suffixIcon: GestureDetector(
          onTap: ontapSuffixicon,
          child: Icon(
            suffixicon,
            color: AppColors.blueColor,
          ),
        ),
        prefixIcon: Icon(
          prefixicon,
          color: AppColors.blueColor,
        ),
        labelStyle: TextStyle(color: AppColors.blueColor),
        labelText: labeltext,
        hintText: hinttext,
      ),
    );
  }
}
