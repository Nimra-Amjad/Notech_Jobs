import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/buttons/quick_select_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';
import 'edit_job_description.dart';

class EditMCQsScreen extends StatefulWidget {
  final String jobid;
  final int index;
  final String question;
  final String correctanswer;
  final List option;
  const EditMCQsScreen({
    super.key,
    required this.question,
    required this.correctanswer,
    required this.option,
    required this.index,
    required this.jobid,
  });

  @override
  State<EditMCQsScreen> createState() => _EditMCQsScreenState();
}

class _EditMCQsScreenState extends State<EditMCQsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _questionController = TextEditingController();
  TextEditingController _correctAnswerController = TextEditingController();
  TextEditingController _option1Controller = TextEditingController();
  TextEditingController _option2Controller = TextEditingController();
  TextEditingController _option3Controller = TextEditingController();
  TextEditingController _option4Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _questionController.text = widget.question;
    _correctAnswerController.text = widget.correctanswer;
    _option1Controller.text = widget.option[0];
    _option2Controller.text = widget.option[1];
    _option3Controller.text = widget.option[2];
    _option4Controller.text = widget.option[3];
  }

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

  Future<void> updateMCQ(
    int index,
    String question,
    List<String> options,
    String correctAnswer,
  ) async {
    var mcqData = {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('jobs')
        .doc(widget.jobid);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['mcqs'] ?? [];

        if (index >= 0 && index < mcqs.length) {
          mcqs[index] = mcqData; // Update the MCQ data at the specified index
        }

        await docRef.update({'mcqs': mcqs});
      }
    });
  }

  void updateSampleMCQ() async {
    final question = _questionController.text;
    final options = [
      _option1Controller.text,
      _option2Controller.text,
      _option3Controller.text,
      _option4Controller.text,
    ];
    final correctAnswer = _correctAnswerController.text;

    final index =
        await updateMCQ(widget.index, question, options, correctAnswer);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditJobDescription()));
  }

  Future<void> deleteMCQ(int index) async {
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('jobs')
        .doc(widget.jobid);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['mcqs'] ?? [];

        if (index >= 0 && index < mcqs.length) {
          mcqs.removeAt(index);
        }

        await docRef.update({'mcqs': mcqs});
      }
    });
  }

  void deleteSampleMCQ() async {
    await deleteMCQ(widget.index);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => EditJobDescription()));
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
        leading: GestureDetector(
            onTap: () {
              _alert();
            },
            child: Icon(Icons.delete)),
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                    if (value!.isEmpty) {
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
                  text: "Next",
                  onTap: () {
                    updateSampleMCQ();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _alert() {
    return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              // insetPadding: EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Are you sure you want to remove?',
                    // maxLines: 2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      QuickSelectButton(
                        text: 'No',
                        ontap: () {
                          Navigator.pop(context);
                        },
                        btncolor: AppColors.primaryWhite,
                        textColor: AppColors.blueColor,
                      ),
                      QuickSelectButton(
                          text: 'Yes',
                          ontap: () {
                            deleteSampleMCQ();
                          })
                    ],
                  )
                ],
              ));
        });
  }
}
