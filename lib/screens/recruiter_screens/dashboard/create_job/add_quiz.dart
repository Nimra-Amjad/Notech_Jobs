import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/view_mcqs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_icons.dart';
import '../../../../components/utils/app_size.dart';
import '../posted_jobs/posted_jobs_screen.dart';

class AddQuiz extends StatefulWidget {
  final model.JobPosted? user;
  final String text;
  final String? job_id;
  const AddQuiz({super.key, this.job_id, required this.text, this.user});

  @override
  State<AddQuiz> createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _correctAnswerController =
      TextEditingController();
  final TextEditingController _option1Controller = TextEditingController();
  final TextEditingController _option2Controller = TextEditingController();
  final TextEditingController _option3Controller = TextEditingController();
  final TextEditingController _option4Controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _questionController.dispose();
    _correctAnswerController.dispose();
    _option1Controller.dispose();
    _option2Controller.dispose();
    _option3Controller.dispose();
    _option4Controller.dispose();
  }

  Future<void> addMCQ(model.JobsMcqs mcq) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('jobs')
        .doc(widget.job_id);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['mcqs'] ?? [];

        mcqs.add(mcq.toJson());

        await docRef.update({'mcqs': mcqs});
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewMcqs(
          text: widget.text,
          job_id: widget.job_id!,
        ),
      ),
    );
  }

  void addSampleMCQ() async {
    final question = _questionController.text;
    final options = [
      _option1Controller.text,
      _option2Controller.text,
      _option3Controller.text,
      _option4Controller.text,
    ];
    final correctAnswer = _correctAnswerController.text;

    final mcq = model.JobsMcqs(
      question: question,
      options: options,
      correctAnswer: correctAnswer,
    );

    await addMCQ(mcq);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Add Quiz',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _questionController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _questionController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Question*"),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _correctAnswerController.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _correctAnswerController,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Correct Answer*"),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _option1Controller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _option1Controller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Option 1*"),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _option2Controller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _option2Controller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Option 2*"),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                TextFormField(
                  cursorHeight: AppSize.textSize * 1.2,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: AppSize.textSize * 1.2,
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        _option3Controller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _option3Controller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Option 3*"),
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
                        _option4Controller.text.trim().isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _option4Controller,
                  autovalidateMode: AutovalidateMode.disabled,
                  keyboardType: TextInputType.emailAddress,
                  decoration: AppDecorations.customTextFieldDecoration(
                      hintText: "Option 4*"),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                CustomButton(
                  text: "Add Mcq",
                  onTap: () {
                    addSampleMCQ();
                  },
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                widget.text == "edit"
                    ? SizedBox()
                    : CustomButton(
                        text: "Don't add mcqs",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostedJobsScreen()));
                        },
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
