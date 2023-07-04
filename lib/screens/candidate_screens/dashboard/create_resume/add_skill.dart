import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_skills.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/buttons/rounded_back_button.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _skillcontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  model.Skills loggedinUser = model.Skills();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _skillcontroller.dispose();
  }

  ///<------------------------------Add Candidate Skills to Database------------------------------>
  addskill() async {
    await FirebaseFirestore.instance.collection("users").doc(user!.uid).update({
      "skills": FieldValue.arrayUnion([_skillcontroller.text])
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ResumeSkills()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        _skillcontroller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _skillcontroller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Skill*"),
                ),
                SizedBox(height: AppSize.paddingBottom * 4),
                CustomButton(
                    text: 'Save',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addskill();
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
