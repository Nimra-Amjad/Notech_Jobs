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
        TextEditingController(text: widget.candidate['qualification']);
    _designationController =
        TextEditingController(text: widget.candidate['passingYear']);
    _joinDateController =
        TextEditingController(text: widget.candidate['collegeName']);
    _endDateController =
        TextEditingController(text: widget.candidate['collegeName']);
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

  ///<------------------------------Add Candidate Education to Database------------------------------>
  editexperience() async {
    model.Experience exp = model.Experience(
      companyName: _companyNameController.text,
      designation: _designationController.text,
      joinDate: _joinDateController.text,
      endDate: _endDateController.text,
    );

  // Retrieve the current experience list from the candidate map
  List<dynamic> experienceList = widget.candidate['experience'];

  // Update the experience at the specified index
  experienceList[widget.index] = exp.toJson();

  // Update the 'experience' field in the 'candidate' map
  widget.candidate['experience'] = experienceList;

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"experience": widget.candidate});

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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    text: "Add Experience",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        editexperience();
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
