import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/login.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/add_a_job_page.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/update_companyprofile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/utils/custom_router.dart';
import '../../components/text/custom_text.dart';
import '../notification.dart';

class RecruiterHomePage extends StatefulWidget {
  const RecruiterHomePage({super.key});

  @override
  State<RecruiterHomePage> createState() => _RecruiterHomePageState();
}

class _RecruiterHomePageState extends State<RecruiterHomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  model.Recruiter loggedinUser = model.Recruiter();
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
      loggedinUser = model.Recruiter.fromSnap(snap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: ListTile(
          title: CustomText(
              text: "Notech",
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.primaryWhite),
          trailing: GestureDetector(
            onTap: () {
              CustomRouter().push(context, const NotificationScreen());
            },
            child: const Icon(
              Icons.notifications,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: AppColors.primaryWhite,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
                text: "No notifications",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontColor: AppColors.primaryBlack),
            SizedBox(
              height: 15.sp,
            ),
            CustomText(
                text: "You have no notification at this time",
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
                fontColor: AppColors.primaryBlack),
            SizedBox(
              height: 8.sp,
            ),
            CustomText(
                text: "thank you",
                fontSize: 15.sp,
                fontWeight: FontWeight.normal,
                fontColor: AppColors.primaryBlack),
            SizedBox(
              height: 15.sp,
            ),
            SvgPicture.asset("assets/images/notification.svg"),
          ],
        ),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 45.sp,
                child: DrawerHeader(
                  decoration: const BoxDecoration(
                    color: AppColors.blueLight,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Container(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                          text: '${loggedinUser.companyname}',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          fontColor: AppColors.primaryWhite)),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecruiterUpdatePage(
                                user: model.Recruiter(
                                    companyname: loggedinUser.companyname,
                                    email: loggedinUser.email,
                                    mobileno: loggedinUser.mobileno,
                                    location: loggedinUser.location))));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: "Personal Details",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: AppColors.blueColor),
                      Icon(Icons.edit)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 204, 204, 208),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.email),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                                text: '${loggedinUser.email}',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.primaryBlack),
                          ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.location_pin),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                                text: '${loggedinUser.location}',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.primaryBlack),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          children: [
                            const Icon(Icons.call),
                            SizedBox(
                              width: 4.w,
                            ),
                            CustomText(
                                text: '${loggedinUser.mobileno}',
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.primaryBlack),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.sp),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecruiterAddJob()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 68.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: AppColors.lightGrey),
                      child: CustomText(
                          text: "Post a Job",
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w400,
                          fontColor: AppColors.quizbluecolor),
                    )),
              ),
              SizedBox(
                height: 1.h,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RecruiterJobPost()));
                },
                child: ListTile(
                  title: CustomText(
                      text: "Jobs Posted",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.blueColor),
                  leading: Icon(
                    Icons.wallet_membership_rounded,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ApplicantsPage()));
                },
                child: ListTile(
                  title: CustomText(
                      text: "Applicants",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.blueColor),
                  leading: Icon(
                    Icons.group,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20.0,
                color: Colors.grey,
              ),
              ListTile(
                title: CustomText(
                    text: "Help",
                    fontSize: 17.sp,
                    fontWeight: FontWeight.normal,
                    fontColor: AppColors.blueColor),
                leading: Icon(
                  Icons.help,
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => VideoCalling()));
                },
                child: ListTile(
                  title: CustomText(
                      text: "Settings",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.blueColor),
                  leading: Icon(
                    Icons.settings,
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20.0,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: ListTile(
                  title: CustomText(
                      text: "Logout",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.blueColor),
                  leading: Icon(Icons.logout),
                ),
              ),
              const Divider(
                thickness: 1,
                height: 20.0,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
