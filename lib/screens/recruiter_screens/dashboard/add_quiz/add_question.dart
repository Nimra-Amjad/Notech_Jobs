import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  final TextEditingController _questioncontroller = TextEditingController();

  final TextEditingController _writeAnswercontroller = TextEditingController();
  final TextEditingController _wronganswer1controller = TextEditingController();
  final TextEditingController _wronganswer2controller = TextEditingController();
  final TextEditingController _wronganswer3controller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _questioncontroller.dispose();
    _writeAnswercontroller.dispose();
    _wronganswer1controller.dispose();
    _wronganswer2controller.dispose();
    _wronganswer3controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Add Questions',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Form(
          key: _formKey,
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
                      controller: _questioncontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      style:
                          TextStyle(color: AppColors.blueColor, fontSize: 20),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Question*',
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
                      controller: _writeAnswercontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      style:
                          TextStyle(color: AppColors.blueColor, fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Write Answer*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          )),
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
                      controller: _wronganswer1controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      style:
                          TextStyle(color: AppColors.blueColor, fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter 1 Wrong Answer*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          )),
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
                      controller: _wronganswer2controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      style:
                          TextStyle(color: AppColors.blueColor, fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter 2 Wrong Answer*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          )),
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
                      controller: _wronganswer3controller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      cursorColor: AppColors.blueColor,
                      style:
                          TextStyle(color: AppColors.blueColor, fontSize: 20),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter 3 Wrong Answer*',
                          hintStyle: TextStyle(
                              color: Colors.grey.shade600, fontSize: 20),
                          prefixIcon: Icon(
                            Icons.remove_circle,
                            color: Colors.red,
                          )),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
