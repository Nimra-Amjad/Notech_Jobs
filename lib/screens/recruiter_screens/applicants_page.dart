import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/app_colors.dart';
import '../../components/text/custom_text.dart';
import '../../components/buttons/rounded_back_button.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

class ApplicantsPage extends StatefulWidget {
  const ApplicantsPage({super.key});

  @override
  State<ApplicantsPage> createState() => _ApplicantsPageState();
}

class _ApplicantsPageState extends State<ApplicantsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  model.JobPosted loggedinUser = model.JobPosted();
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection("jobs")
        .doc()
        .get();
    setState(() {
      loggedinUser = model.JobPosted.fromSnap(snap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomAppBar(color: Colors.white),
        backgroundColor: AppColors.gradientcolor1,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                child: Padding(
                    padding: EdgeInsets.all(18.sp),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: BackButtonRounded(
                            color: AppColors.primaryWhite,
                            iconcolor: AppColors.primaryBlack,
                            bordercolor: AppColors.primaryGrey,
                          ),
                        ),
                        SizedBox(
                          width: 35.sp,
                        ),
                        CustomText(
                            text: "Applicants",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            fontColor: AppColors.primaryBlack),
                      ],
                    )),
              ),
              Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(user!.uid)
                          .collection('jobs')
                          .snapshots(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot jobs =
                                  snapshot.data!.docs[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobs[index]['pdfurl'],
                                        style: const TextStyle(
                                            color: AppColors.blueColor),
                                      ),
                                      const SizedBox(
                                        height: 12.0,
                                      ),
                                      const Text(
                                        "Posted 1 min ago",
                                        style: TextStyle(fontSize: 11),
                                      ),
                                      const Divider(
                                        thickness: 0.5,
                                        height: 20.0,
                                        color: Colors.grey,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                width: 80,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: AppColors.blueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  "Edit",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              // deleteNestedSubcollections(jobs['id']);
                                            },
                                            child: Container(
                                                width: 80,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: AppColors.blueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  "Remove",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )),
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          GestureDetector(
                                            onTap: () {},
                                            child: Container(
                                                width: 80,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: AppColors.blueColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Text(
                                                  "Applicants",
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      })),
            ],
          ),
        ));
  }
}
