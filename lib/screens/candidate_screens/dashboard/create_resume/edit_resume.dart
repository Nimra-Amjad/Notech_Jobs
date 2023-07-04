import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_title.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';
import '../../../../resources/auth_methods.dart';

class EditResumeTitle extends StatefulWidget {
  final model.Candidate candidate;
  const EditResumeTitle({super.key, required this.candidate});

  @override
  State<EditResumeTitle> createState() => _EditResumeTitleState();
}

class _EditResumeTitleState extends State<EditResumeTitle> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _resumeTitleController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();

  @override
  void initState() {
    _resumeTitleController =
        TextEditingController(text: widget.candidate.resumeTitle);
    _experienceController = TextEditingController(
        text: widget.candidate.yearsOfExperience.toString());
    super.initState();
  }

  @override
  void dispose() {
    _resumeTitleController.dispose();
    _experienceController.dispose();
    super.dispose();
  }

  void updateResumeData() async {
    await AuthMethods()
        .updateCandidateResumeTitle(_resumeTitleController.text,
            int.tryParse(_experienceController.text))
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ResumeTitleScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resume Title"),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: AppSize.paddingBottom,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.textboxfillcolor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: TextFormField(
                          controller: _resumeTitleController,
                          validator: (value) {
                            if (value!.isEmpty||
                            _resumeTitleController.text.trim().isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                          cursorColor: AppColors.blueColor,
                          style: TextStyle(
                              color: AppColors.blueColor, fontSize: 20),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Resume Title*',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: 1.h,
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.textboxfillcolor,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.sp),
                        child: TextFormField(
                          controller: _experienceController,
                          validator: (value) {
                            if (value!.isEmpty||
                            _experienceController.text.trim().isEmpty) {
                              return "* Required";
                            }
                            return null;
                          },
                          cursorColor: AppColors.blueColor,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: AppColors.blueColor, fontSize: 20),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Years of experience*',
                            hintStyle: TextStyle(
                                color: Colors.grey.shade600, fontSize: 20),
                          ),
                        ),
                      )),
                  SizedBox(
                    height: AppSize.paddingBottom * 3,
                  ),
                  CustomButton(
                      text: 'Next',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateResumeData();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
