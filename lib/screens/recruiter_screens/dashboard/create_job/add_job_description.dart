import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_icons.dart';
import '../../../../components/utils/app_size.dart';
import 'add_skill_screen.dart';
import 'job_skills.dart';

class AddJobDescription extends StatefulWidget {
  const AddJobDescription({super.key});

  @override
  State<AddJobDescription> createState() => _AddJobDescriptionState();
}

class _AddJobDescriptionState extends State<AddJobDescription> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _jobTitlecontroller = TextEditingController();

  final TextEditingController _jobDescriptioncontroller =
      TextEditingController();
  final TextEditingController _jobyearsRequiredcontroller =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jobTitlecontroller.dispose();
    _jobDescriptioncontroller.dispose();
  }

  String jobTypeDropDown = 'Select Job Type';
  addjob() async {
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    //add user to our database
    model.JobPosted job = model.JobPosted(
      id: random,
      jobtitle: _jobTitlecontroller.text,
      jobdes: _jobDescriptioncontroller.text,
      jobtype: jobTypeDropDown,
      yearsrequired: int.parse(_jobyearsRequiredcontroller.text),
      uid: user!.uid,
    );

//add jobs to firestore collection
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc(random)
        .set(job.toJson());
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddSkillScreen(job_id: random)));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Add Job Description',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              children: [
                SizedBox(height: AppSize.paddingBottom * 1),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _jobTitlecontroller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _jobTitlecontroller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Job Title*"),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: AppColors.textboxfillcolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.sp),
                      child: TextFormField(
                        controller: _jobDescriptioncontroller,
                        validator: (value) {
                          if (value!.isEmpty ||
                              _jobDescriptioncontroller.text.trim().isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        maxLines: 10,
                        cursorColor: AppColors.blueColor,
                        style:
                            TextStyle(color: AppColors.blueColor, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Job description*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: double.infinity,
                  height: 6.h,
                  decoration: BoxDecoration(
                      color: AppColors.textboxfillcolor,
                      border: Border.all(color: AppColors.textboxfillcolor),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        borderRadius: BorderRadius.circular(20),
                        icon: Icon(
                          AppIcons.dropdownIcon,
                          color: AppColors.blueColor,
                        ),
                        isExpanded: true,
                        value: jobTypeDropDown,
                        items: [
                          'Select Job Type',
                          'Full Time',
                          'Part Time',
                          'Hybrid',
                          'Remote'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                              value: value,
                              child: CustomText(
                                text: value,
                                fontWeight: FontWeight.normal,
                                fontColor: Colors.grey.shade600,
                              ));
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            jobTypeDropDown = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
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
                        controller: _jobyearsRequiredcontroller,
                        validator: (value) {
                          if (value!.isEmpty ||
                              _jobyearsRequiredcontroller.text.trim().isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        keyboardType: TextInputType.number,
                        style:
                            TextStyle(color: AppColors.blueColor, fontSize: 20),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'How many number of years required*',
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
                        addjob();
                      }
                    })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
