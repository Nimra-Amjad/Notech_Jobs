import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/add_more_skills.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/create_job/edit_job_description.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import '../../../../components/utils/app_colors.dart';

class EditSkills extends StatefulWidget {
  final model.JobPosted user;
  const EditSkills({super.key, required this.user});

  @override
  State<EditSkills> createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Skills loggedinUser = model.Skills();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallSkills();
  }

  //<---------------------------------Get Candidate Skills--------------------------------------------->
  List requiredSkills = [];
  void getallSkills() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('jobs')
        .doc(widget.user.id)
        .get()
        .then((value) {
      setState(() {
        requiredSkills = value['skills'];
      });
      print(requiredSkills);
    });
  }

  //<---------------------------------Remove Candidate Skills--------------------------------------------->
  Future<void> removeElementFromList(String element) async {
    try {
      setState(() {
        requiredSkills.remove(element);
        print(requiredSkills);
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .collection('jobs')
          .doc(widget.user.id)
          .update({"skills": requiredSkills});
    } catch (error) {
      print('Error removing element from list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditJobDescription(
                    user: model.JobPosted(
                        id: widget.user.id,
                        jobtitle: widget.user.jobtitle,
                        jobdes: widget.user.jobdes,
                        jobtype: widget.user.jobtype,
                        yearsrequired: widget.user.yearsrequired,
                        skills: widget.user.skills))));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'Edit your skills',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: requiredSkills.length,
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 7.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: requiredSkills[index].toString(),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            fontColor: AppColors.primaryBlack),
                        GestureDetector(
                          onTap: () {
                            removeElementFromList(
                              requiredSkills[index].toString(),
                            );
                          },
                          child: Icon(
                            Icons.remove_circle,
                            color: AppColors.blueColor,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        )),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(left: 20.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                  text: "Add Skill",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddMoreSkills(
                                  jobid: widget.user.id!,
                                )));
                  }),
              SizedBox(
                height: 1.h,
              ),
              CustomButton(
                  text: "Back",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditJobDescription(
                                user: model.JobPosted(
                                    id: widget.user.id,
                                    jobtitle: widget.user.jobtitle,
                                    jobdes: widget.user.jobdes,
                                    jobtype: widget.user.jobtype,
                                    yearsrequired: widget.user.yearsrequired,
                                    skills: widget.user.skills))));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
