import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/job_skills.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/buttons/rounded_back_button.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';

class AddSkillScreen extends StatefulWidget {
  final String job_id;
  const AddSkillScreen({super.key, required this.job_id});

  @override
  State<AddSkillScreen> createState() => _AddSkillScreenState();
}

class _AddSkillScreenState extends State<AddSkillScreen> {
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
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("jobs")
        .doc(widget.job_id)
        .update({
      "skills": FieldValue.arrayUnion([_skillcontroller.text])
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => JobSkillsScreen(
                  job_id: widget.job_id,
                )));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackButtonRounded(
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: AppSize.paddingBottom * 1),
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
                  controller: _skillcontroller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Required Skills*"),
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
