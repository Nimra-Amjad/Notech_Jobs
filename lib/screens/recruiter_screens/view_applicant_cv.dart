import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/buttons/rounded_back_button.dart';
import '../../components/text/custom_text.dart';
import '../../components/utils/app_colors.dart';

class ViewApplicantsResume extends StatefulWidget {
  String filename;
  String fileurl;
  ViewApplicantsResume({
    Key? key,
    required this.filename,
    required this.fileurl,
  }) : super(key: key);

  @override
  State<ViewApplicantsResume> createState() => _ViewApplicantsResumeState();
}

class _ViewApplicantsResumeState extends State<ViewApplicantsResume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 2.h),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButtonRounded(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.sp),
                  child: CustomText(
                      text: widget.filename,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.primaryBlack),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.sp,
                  ),
                  Container(
                    width: double.infinity,
                    height: 100.sp,
                    // decoration: BoxDecoration(color: Colors.amber),
                    child: SfPdfViewer.network(widget.fileurl),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.sp),
                    child: CustomButton(text: "Download", onTap: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
