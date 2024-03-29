import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_size.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../../components/buttons/quick_select_button.dart';
import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../applicants.dart/applied_candidates_screen.dart';
import '../create_job/edit_job_description.dart';
import '../dashboard.dart';

class PostedJobsScreen extends StatefulWidget {
  const PostedJobsScreen({super.key});

  @override
  State<PostedJobsScreen> createState() => _PostedJobsScreenState();
}

class _PostedJobsScreenState extends State<PostedJobsScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchcontroller.dispose();
  }

  void deleteNestedSubcollections(String id) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("jobs")
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => RecruiterDashBoard()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blueColor,
          title: CustomText(
            text: 'All Jobs',
            fontColor: AppColors.primaryWhite,
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            children: [
              SizedBox(
                height: AppSize.paddingAll,
              ),
              TextFormField(
                cursorHeight: AppSize.textSize * 1.2,
                style: TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: AppSize.textSize * 1.2,
                ),
                cursorColor: Color.fromARGB(255, 22, 42, 222),
                controller: _searchcontroller,
                autovalidateMode: AutovalidateMode.disabled,
                keyboardType: TextInputType.emailAddress,
                decoration: AppDecorations.customTextFieldDecoration(
                    hintText: "Search Jobs"),
              ),
              SizedBox(
                height: AppSize.paddingAll,
              ),
              Expanded(
                  child: Container(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(user!.uid)
                        .collection('jobs')
                        .snapshots(),
                    builder: (context, snapshot) {
                      return snapshot.hasData
                          ? ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot jobs =
                                    snapshot.data!.docs[index];
                                return Card(
                                  child: Padding(
                                    padding: EdgeInsets.all(14.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: jobs['jobtitle'],
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                            fontColor: AppColors.blueColor),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        CustomText(
                                            text: jobs['jobdes'],
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.normal,
                                            fontColor: AppColors.quizbluecolor),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        CustomText(
                                            text: "Posted 1 min ago",
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal,
                                            fontColor: AppColors.primaryBlack),
                                        const Divider(
                                          thickness: 0.5,
                                          height: 20.0,
                                          color: Colors.grey,
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                print(jobs['mcqs']);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => EditJobDescription(
                                                            user: model.JobPosted(
                                                                id: jobs['id'],
                                                                jobtitle: jobs[
                                                                    'jobtitle'],
                                                                jobdes: jobs[
                                                                    'jobdes'],
                                                                jobtype: jobs[
                                                                    'jobtype'],
                                                                yearsrequired: jobs[
                                                                    'yearsrequired'],
                                                                skills: jobs[
                                                                    'skills'],
                                                                mcqs: jobs[
                                                                    'mcqs']))));
                                              },
                                              child: Container(
                                                  width: 80,
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.blueLight,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: CustomText(
                                                      text: "Edit",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontColor: AppColors
                                                          .primaryWhite)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                _alert(jobs['id']);
                                              },
                                              child: Container(
                                                  width: 80,
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.blueLight,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: CustomText(
                                                      text: "Remove",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontColor: AppColors
                                                          .primaryWhite)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AppliedCandidatesScreen(
                                                              job_id:
                                                                  jobs['id'],
                                                              job_name: jobs[
                                                                  'jobtitle'],
                                                            )));
                                              },
                                              child: Container(
                                                  width: 80,
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          AppColors.blueLight,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: CustomText(
                                                      text: "Applicants",
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontColor: AppColors
                                                          .primaryWhite)),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const CircularProgressIndicator();
                    }),
              ))
            ],
          ),
        )),
      ),
    );
  }

  _alert(String id) {
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
                            deleteNestedSubcollections(id);
                            Navigator.pop(context);
                          })
                    ],
                  )
                ],
              ));
        });
  }
}
