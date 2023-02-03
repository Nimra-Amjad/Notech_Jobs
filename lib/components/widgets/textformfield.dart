import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxline;
  const TextFieldInput(
      {super.key,
      required this.textEditingController,
      this.isPass = false,
      required this.hintText,
      required this.textInputType,
      this.inputFormatters,
      required this.validator,
      this.maxline});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: TextFormField(
        maxLines: maxline,
        validator: validator,
        inputFormatters: inputFormatters,
        style: const TextStyle(color: AppColors.blueColor),
        controller: textEditingController,
        cursorColor: AppColors.blueColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 204, 204, 208)),
          border: InputBorder.none,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide:
                  BorderSide(color: Color.fromARGB(255, 240, 240, 240))),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(
                color: AppColors.blueColor,
              )),
          filled: true,
          fillColor: const Color.fromARGB(255, 240, 240, 240),
          contentPadding: const EdgeInsets.all(8),
        ),
        keyboardType: textInputType,
      ),
    );
  }
}
