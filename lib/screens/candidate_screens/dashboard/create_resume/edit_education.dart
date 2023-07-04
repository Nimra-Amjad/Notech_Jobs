import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_education.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';

class EditResumeEducation extends StatefulWidget {
  // final model.Candidate candidate;
  final Map<String, dynamic> candidate;
  final int index;
  const EditResumeEducation(
      {super.key, required this.candidate, required this.index});

  @override
  State<EditResumeEducation> createState() => _EditResumeEducationState();
}

class _EditResumeEducationState extends State<EditResumeEducation> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _passingYearController = TextEditingController();
  TextEditingController _collegeNameController = TextEditingController();

  List<model.Education> educationList = [];

  @override
  void initState() {
    _qualificationController =
        TextEditingController(text: widget.candidate['qualification']);
    _passingYearController =
        TextEditingController(text: widget.candidate['passingYear']);
    _collegeNameController =
        TextEditingController(text: widget.candidate['collegeName']);
    super.initState();
  }

  @override
  void dispose() {
    _qualificationController.dispose();
    _passingYearController.dispose();
    _collegeNameController.dispose();
    super.dispose();
  }

  ///<------------------------------Edit Candidate Education to Database------------------------------>
  Future<void> updateMCQ(
    int index,
    String collegeName,
    String passingyear,
    String qualification,
  ) async {
    var mcqData = {
      'collegeName': collegeName,
      'passingYear': passingyear,
      'qualification': qualification,
    };

    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['educations'] ?? [];

        if (index >= 0 && index < mcqs.length) {
          mcqs[index] = mcqData; // Update the MCQ data at the specified index
        }

        await docRef.update({'educations': mcqs});
      }
    });
  }

  void updateSampleMCQ() async {
    final collegename = _collegeNameController.text;
    final passingyear = _passingYearController.text;
    final qualification = _qualificationController.text;

    final index =
        await updateMCQ(widget.index, collegename, passingyear, qualification);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddEducation()));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Edit Your Education',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.paddingBottom,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _qualificationController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _qualificationController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Qualification*"),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _passingYearController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _passingYearController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.number,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Passing Year*"),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _collegeNameController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _collegeNameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "School/College Name*"),
                ),
                SizedBox(
                  height: AppSize.paddingBottom * 5,
                ),
                CustomButton(
                    text: "Update Education",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        updateSampleMCQ();
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
