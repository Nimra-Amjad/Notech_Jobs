import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/add_skill.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_education.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/create_resume/resume_title.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import '../../../../components/utils/app_colors.dart';

class ResumeSkills extends StatefulWidget {
  const ResumeSkills({super.key});

  @override
  State<ResumeSkills> createState() => _ResumeSkillsState();
}

class _ResumeSkillsState extends State<ResumeSkills> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Skills loggedinUser = model.Skills();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallSkills();
  }

  //<---------------------------------Get Candidate Skills--------------------------------------------->
  List candidateSkills = [];
  void getallSkills() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        candidateSkills = value['skills'];
      });
      print(candidateSkills);
    });
  }

  //<---------------------------------Remove Candidate Skills--------------------------------------------->
  Future<void> removeElementFromList(String element) async {
    try {
      setState(() {
        candidateSkills.remove(element);
        print(candidateSkills);
      });

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"skills": candidateSkills});
    } catch (error) {
      print('Error removing element from list: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ResumeTitleScreen()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'Add your skills',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: candidateSkills.length,
              itemBuilder: (context, index) {
                return candidateSkills.isEmpty
                    ? CustomText(text: "You have not add any skill yet")
                    : Container(
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
                                  text: candidateSkills[index].toString(),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w500,
                                  fontColor: AppColors.primaryBlack),
                              GestureDetector(
                                onTap: () {
                                  removeElementFromList(
                                    candidateSkills[index].toString(),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddSkill()));
                  }),
              SizedBox(
                height: 1.h,
              ),
              CustomButton(
                  text: "Next",
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResumeEducation()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
