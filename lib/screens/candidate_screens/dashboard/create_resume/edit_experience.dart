import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_education.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_experience.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';

class EditResumeExperience extends StatefulWidget {
  // final model.Candidate candidate;
  final Map<String, dynamic> candidate;
  final int index;
  const EditResumeExperience(
      {super.key, required this.candidate, required this.index});

  @override
  State<EditResumeExperience> createState() => _EditResumeExperienceState();
}

class _EditResumeExperienceState extends State<EditResumeExperience> {
  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _designationController = TextEditingController();
  TextEditingController _joinDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  List<model.Education> educationList = [];

  @override
  void initState() {
    _companyNameController =
        TextEditingController(text: widget.candidate['companyName']);
    _designationController =
        TextEditingController(text: widget.candidate['designation']);
    _joinDateController =
        TextEditingController(text: widget.candidate['joinDate']);
    _endDateController =
        TextEditingController(text: widget.candidate['endDate']);
    super.initState();
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _designationController.dispose();
    _joinDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  ///<------------------------------Edit Candidate Experience to Database------------------------------>
  Future<void> updateMCQ(
    int index,
    String companyName,
    String designation,
    String enddate,
    String joindate,
  ) async {
    var mcqData = {
      'companyName': companyName,
      'designation': designation,
      'endDate': enddate,
      'joinDate': joindate,
    };

    final docRef =
        FirebaseFirestore.instance.collection('users').doc(user!.uid);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['experience'] ?? [];

        if (index >= 0 && index < mcqs.length) {
          mcqs[index] = mcqData; // Update the MCQ data at the specified index
        }

        await docRef.update({'experience': mcqs});
      }
    });
  }

  void updateSampleMCQ() async {
    final companyname = _companyNameController.text;
    final designation = _designationController.text;
    final enddate = _endDateController.text;
    final startdate = _joinDateController.text;

    final index = await updateMCQ(
        widget.index, companyname, designation, enddate, startdate);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddExperience()));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Edit Your Experience',
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
                        _companyNameController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _companyNameController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Company Name*"),
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
                        _designationController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _designationController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Designation*"),
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
                        _joinDateController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _joinDateController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Joining Date*"),
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
                        _endDateController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _endDateController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "End Date*"),
                ),
                SizedBox(
                  height: AppSize.paddingBottom * 5,
                ),
                CustomButton(
                    text: "Update Experience",
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
