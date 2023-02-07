import 'dart:core';

import 'package:flutter/material.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../utils/app_colors.dart';
import '../utils/app_size.dart';

class MessageCard extends StatelessWidget {
  const MessageCard(
      {Key? key,
      this.textColor,
      this.templateColor,
      required this.messageController})
      : super(key: key);

  final Color? templateColor, textColor;
  final TextEditingController messageController;

  @override
  Widget build(BuildContext context) {
    return SimpleShadow(
      color: AppColors.primaryBlack.withOpacity(0.3),
      sigma: 5,
      child: Container(
        padding: EdgeInsets.only(
            left: AppSize.paddingLeft / 2, right: AppSize.paddingRight / 2),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primaryWhite,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: TextFormField(
          cursorColor: AppColors.primaryBlack,
          maxLines: 7,
          keyboardType: TextInputType.text,
          controller: messageController,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.textSize,
          ),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(
                  top: AppSize.paddingLeft / 2,
                  bottom: AppSize.paddingLeft / 2,
                  left: AppSize.paddingLeft / 2,
                  right: AppSize.paddingRight / 2),
              hintText: "Enter Your Message Here",
              hintStyle: TextStyle(
                color: textColor,
                fontSize: AppSize.textSize,
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none),
          cursorHeight: AppSize.textSize * 1.2,
        ),
      ),
    );
  }
}
