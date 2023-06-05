import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/view_mcqs.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_icons.dart';
import '../../../../components/utils/app_size.dart';

class AddQuiz extends StatefulWidget {
  final String job_id;
  const AddQuiz({super.key, required this.job_id});

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
  String categoryDropDown = 'Select Category';
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

  List jobMcqs = [];
  Future<void> addMCQ(String question, List<String> options,
      String correctAnswer, String category) async {
    var mcqData = {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
      'category': category,
    };

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('jobs')
        .doc(widget.job_id);

    await docRef.get().then((value) async {
      if (value.exists) {
        var jobData = value.data();
        var mcqs = jobData!['mcqs'] ??
            []; // Retrieve the existing MCQs or initialize an empty list

        mcqs.add(mcqData); // Add the new MCQ data to the list

        await docRef.update(
            {'mcqs': mcqs}); // Update the 'mcqs' field with the updated list
      }
    });
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewMcqs(
                  job_id: widget.job_id,
                )));
  }

// Usage example
  void addSampleMCQ() async {
    final question = _questionController.text;
    final options = [
      _option1Controller.text,
      _option2Controller.text,
      _option3Controller.text,
      _option4Controller.text
    ];
    final correctAnswer = _correctAnswerController.text;
    final category = categoryDropDown;

    await addMCQ(question, options, correctAnswer, category);
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
                        value: categoryDropDown,
                        items: [
                          'Select Category',
                          'Flutter',
                          'React Native',
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
                            categoryDropDown = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                CustomButton(
                  text: "Next",
                  onTap: () {
                    addSampleMCQ();
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
