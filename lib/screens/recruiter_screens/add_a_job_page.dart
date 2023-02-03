import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';

import '../../components/utils/colors.dart';
import '../../components/widgets/textformfield.dart';

class RecruiterAddJob extends StatefulWidget {
  const RecruiterAddJob({super.key});

  @override
  State<RecruiterAddJob> createState() => _RecruiterAddJobState();
}

class _RecruiterAddJobState extends State<RecruiterAddJob> {
  User? user = FirebaseAuth.instance.currentUser;
  List joblist = [];

  final TextEditingController _jobtitlecontroller = TextEditingController();
  final TextEditingController _jobdescontroller = TextEditingController();
  final TextEditingController _jobtypecontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _jobtitlecontroller.dispose();
    _jobdescontroller.dispose();
    _jobtypecontroller.dispose();
  }

  addjob() async {
    // joblist.add({
    //   "jobtitle": _jobtitlecontroller.text,
    //   "jobdes": _jobdescontroller.text,
    //   "jobtype": _jobtypecontroller.text
    // });
    //uploading file to firebase collection
    // await FirebaseFirestore.instance
    //     .collection("users")
    //     .doc(user!.uid)
    //     .update({'jobs': joblist});
    // //.doc(user!.uid).set({

    // });

    final random = Random().nextInt(999999).toString().padLeft(6, '0');
    //add user to our database
    model.JobPosted job = model.JobPosted(
      id: random,
      jobtitle: _jobtitlecontroller.text,
      jobdes: _jobdescontroller.text,
      jobtype: _jobtypecontroller.text,
      uid: user!.uid,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc(random)
        .set(job.toJson());
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RecruiterJobPost()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Job Description"),
        backgroundColor: AppColors.blueColor,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text("Job Title :",
                  style: TextStyle(fontSize: 18, color: AppColors.blueColor)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  }
                  return null;
                },
                textEditingController: _jobtitlecontroller,
                hintText: "Job Title",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text("Job Description :",
                  style: TextStyle(fontSize: 18, color: AppColors.blueColor)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
              isPass: false,
              maxline: 10,
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  }
                  return null;
                },
                textEditingController: _jobdescontroller,
                hintText: "Job Description",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 14.0),
              child: Text("Job Type :",
                  style: TextStyle(fontSize: 18, color: AppColors.blueColor)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFieldInput(
                validator: (value) {
                  if (value!.isEmpty) {
                    return '* required';
                  }
                  return null;
                },
                textEditingController: _jobtypecontroller,
                hintText: "Job Type",
                textInputType: TextInputType.name),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: addjob,
              child: Padding(
                padding: EdgeInsets.only(left: 14.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 160,
                  height: 50,
                  decoration: BoxDecoration(
                      color: AppColors.blueColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Save",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            )
                  ],
                ),
          )),
    );
  }
}
