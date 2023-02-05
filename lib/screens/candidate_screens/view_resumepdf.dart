import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';

import '../../components/buttons/rounded_back_button.dart';

class CandidateViewResume extends StatelessWidget {
  String filename;
  String fileurl;
  CandidateViewResume({
    Key? key,
    required this.filename,
    required this.fileurl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          leading: BackButtonRounded(
            onTap: () {
              Navigator.pop(context);
            },
            color: AppColors.primaryWhite,
            bordercolor: AppColors.primaryWhite,
            iconcolor: AppColors.primaryBlack,
          ),
          title: CustomText(
              text: filename,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.primaryWhite),
          elevation: 0.0,
        ),
        body: SfPdfViewer.network(
          fileurl,
          initialScrollOffset: Offset(0, 500),
        ));
  }
}
