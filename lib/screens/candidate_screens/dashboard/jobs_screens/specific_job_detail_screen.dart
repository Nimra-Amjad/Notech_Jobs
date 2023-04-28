import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/buttons/rounded_back_button.dart';
import '../../../../components/text/custom_text.dart';

class JobDetailScreen extends StatefulWidget {
  final String jobTitle;
  final String jobDescription;
  final String jobType;
  final List<dynamic> requiredskills;
  const JobDetailScreen(
      {super.key,
      required this.jobTitle,
      required this.jobDescription,
      required this.jobType,
      required this.requiredskills});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BackButtonRounded(),
            SizedBox(
              height: AppSize.paddingBottom * 2,
            ),
            Expanded(
                child: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Job Title:',
                              fontSize: 18.sp,
                              fontColor: AppColors.blueColor,
                              fontWeight: FontWeight.normal,
                            ),
                            CustomText(
                              text: widget.jobTitle,
                              fontSize: 20.sp,
                            ),
                            SizedBox(
                              height: AppSize.paddingAll,
                            ),
                            CustomText(
                              text: 'Job Description:',
                              fontSize: 18.sp,
                              fontColor: AppColors.blueColor,
                              fontWeight: FontWeight.normal,
                            ),
                            CustomText(
                              text: widget.jobDescription,
                              // fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: AppSize.paddingAll,
                            ),
                            CustomText(
                              text: 'Job Type:',
                              fontSize: 18.sp,
                              fontColor: AppColors.blueColor,
                              fontWeight: FontWeight.normal,
                            ),
                            CustomText(
                              text: widget.jobType,
                              // fontSize: 20.sp,
                              fontWeight: FontWeight.normal,
                            ),
                            SizedBox(
                              height: AppSize.paddingAll,
                            ),
                            CustomText(
                              text: 'Required Skills:',
                              fontSize: 18.sp,
                              fontColor: AppColors.blueColor,
                              fontWeight: FontWeight.normal,
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: widget.requiredskills.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return CustomText(
                                    text: '${widget.requiredskills[index]}',
                                    fontWeight: FontWeight.normal,
                                  );
                                }),
                            const Divider(
                              thickness: 0.5,
                              height: 20.0,
                              color: Colors.grey,
                            ),
                            GestureDetector(
                              onTap: () {
                                // apply(jobs['uid'], jobs['id']);
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.blueLight,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                    Text(
                                      "Apply Now",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Icon(
                                      Icons.arrow_upward_outlined,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      )),
    );
  }
}
