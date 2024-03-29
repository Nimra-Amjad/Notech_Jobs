import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/interview_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as candiadteModel;
import 'package:notech_mobile_app/model/recruiter_model.dart' as recruiterModel;

import '../../../../../components/buttons/custom_button.dart';
import '../../../../../components/text/custom_text.dart';
import '../../../../../components/utils/app_colors.dart';
import '../applied_candidates_screen.dart';

class ScheduleInterview extends StatefulWidget {
  final String? job_id;
  final String? appl_id;
  final String? appl_name;
  final String? job_title;
  const ScheduleInterview(
      {super.key, this.job_id, this.appl_id, this.appl_name, this.job_title});

  @override
  State<ScheduleInterview> createState() => _ScheduleInterviewState();
}

class _ScheduleInterviewState extends State<ScheduleInterview> {
  final TextEditingController _datecontroller = TextEditingController();
  final TextEditingController _timecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  recruiterModel.Recruiter loggedinUser = recruiterModel.Recruiter();

  @override
  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    setState(() {
      loggedinUser = recruiterModel.Recruiter.fromSnap(snap);
    });
  }

  ///<------------------------------Add Candidate Interviews to Database------------------------------>
  addinterview() async {
    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    candiadteModel.Interviews int = candiadteModel.Interviews(
      jobtitle: widget.job_title,
      date: _datecontroller.text,
      time: _timecontroller.text,
      id: random,
      jobid: widget.job_id,
      companyUid: loggedinUser.uid,
      userUid: widget.appl_id,
    );
    recruiterModel.Interviews recruiter_int = recruiterModel.Interviews(
      jobTitle: widget.job_title,
      applicantName: widget.appl_name,
      date: _datecontroller.text,
      time: _timecontroller.text,
      id: random,
      jobid: widget.job_id,
      companyUid: loggedinUser.uid,
      userUid: widget.appl_id,
    );
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("jobs")
        .doc(widget.job_id)
        .update({
      "interviews": FieldValue.arrayUnion([recruiter_int.toJson()])
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.appl_id)
        .update({
      "interviews": FieldValue.arrayUnion([int.toJson()])
    });
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecruiterInterviewsScreen()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _datecontroller.dispose();
    _timecontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'Schedule Interview',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.textboxfillcolor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: TextFormField(
                      controller: _datecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.calendar_today),
                          labelText: "Enter Date"),
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          String formattedDate =
                              DateFormat('d MMMM yyyy').format(pickedDate);
                          setState(() {
                            _datecontroller.text = formattedDate;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.paddingAll,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.textboxfillcolor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.sp),
                    child: TextFormField(
                      controller: _timecontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(Icons.alarm),
                          labelText: "Enter Time"),
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );

                        if (pickedTime != null) {
                          DateTime parsedTime = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            pickedTime.hour,
                            pickedTime.minute,
                          );
                          String formattedTime =
                              DateFormat('h:mm a').format(parsedTime);

                          setState(() {
                            _timecontroller.text = formattedTime;
                          });
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: AppSize.paddingBottom,
                ),
                CustomButton(
                    text: "Schedule Interview",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        addinterview();
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
