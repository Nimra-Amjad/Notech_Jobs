import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/add_quiz.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/edit_mcq.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/edit_skills.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/posted_jobs/posted_jobs_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../../components/buttons/custom_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_icons.dart';
import '../../../../components/utils/app_size.dart';
import '../../../../resources/auth_methods.dart';

class EditJobDescription extends StatefulWidget {
  final model.JobPosted? user;
  const EditJobDescription({super.key, this.user});

  @override
  State<EditJobDescription> createState() => _EditJobDescriptionState();
}

class _EditJobDescriptionState extends State<EditJobDescription> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _jobtitlecontroller = TextEditingController();
  TextEditingController _jobdescontroller = TextEditingController();
  TextEditingController _yearsrequiredcontroller = TextEditingController();
  String? jobTypeDropDown;

  @override
  void initState() {
    _jobtitlecontroller = TextEditingController(text: widget.user!.jobtitle);
    _jobdescontroller = TextEditingController(text: widget.user!.jobdes);
    _yearsrequiredcontroller =
        TextEditingController(text: widget.user!.yearsrequired.toString());
    jobTypeDropDown = widget.user!.jobtype;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _jobtitlecontroller.dispose();
    _jobdescontroller.dispose();
    _yearsrequiredcontroller.dispose();
  }

  void updatejobdata() async {
    await AuthMethods()
        .updatejobdata(
            widget.user!.id,
            _jobtitlecontroller.text,
            _jobdescontroller.text,
            jobTypeDropDown,
            int.parse(
              _yearsrequiredcontroller.text,
            ),
            widget.user!.skills)
        .then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PostedJobsScreen()));
    });
  }

  bool isExpanded = false;
  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Edit Job Description',
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
                    if (value!.isEmpty) {
                      return "* Required";
                    }
                    return null;
                  },
                  cursorColor: AppColors.blueColor,
                  controller: _jobtitlecontroller,
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
                        controller: _jobdescontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
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
                        controller: _yearsrequiredcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
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
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "Skills"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditSkills(
                                    user: model.JobPosted(
                                        id: widget.user!.id,
                                        jobtitle: widget.user!.jobtitle,
                                        jobdes: widget.user!.jobdes,
                                        jobtype: widget.user!.jobtype,
                                        yearsrequired:
                                            widget.user!.yearsrequired,
                                        skills: widget.user!.skills))));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.edit),
                          CustomText(
                            text: "Edit skills",
                            fontColor: AppColors.blueColor,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 20.h,
                  child: ListView.builder(
                      itemCount: widget.user!.skills?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.sp),
                          child: Row(
                            children: [
                              Icon(Icons.check),
                              CustomText(text: widget.user!.skills![index])
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text: "MCQ's"),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddQuiz(
                                      job_id: widget.user!.id,
                                    )));
                      },
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          CustomText(
                            text: "Add more questions",
                            fontColor: AppColors.blueColor,
                            fontSize: 11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 20.h,
                  child: ListView.builder(
                    itemCount: widget.user!.mcqs?.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Get the current question
                      Map<String, dynamic> question = widget.user!.mcqs![index];

                      // Extract the options list
                      List<String> options = question['options'].cast<String>();

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                print(index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditMCQsScreen(
                                            jobid: widget.user!.id!,
                                            index: index,
                                            question: question['question'],
                                            correctanswer:
                                                question['correctAnswer'],
                                            option: options)));
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          toggleExpanded();
                                        },
                                        child: Icon(
                                          Icons.arrow_drop_down,
                                          size: 6.h,
                                        ),
                                      ),
                                      CustomText(text: question['question']),
                                    ],
                                  ),
                                  Icon(Icons.edit),
                                ],
                              ),
                            ),
                            if (isExpanded == true)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        'Correct Answer: ${question['correctAnswer']}',
                                    fontWeight: FontWeight.normal,
                                  ),
                                  for (String option in options)
                                    CustomText(
                                      text: option,
                                      fontWeight: FontWeight.normal,
                                    ),
                                ],
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: AppSize.paddingBottom * 3,
                ),
                CustomButton(
                    text: 'Next',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        updatejobdata();
                      }
                    }),
                SizedBox(
                  height: AppSize.paddingBottom,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
