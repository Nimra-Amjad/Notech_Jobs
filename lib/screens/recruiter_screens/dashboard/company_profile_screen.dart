import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/update_companyprofile.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

import '../../../components/text/custom_text.dart';
import '../../../components/utils/app_assets.dart';
import '../../../components/utils/app_colors.dart';
import '../../../components/utils/app_size.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});

  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
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
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Column(
            children: [
              SizedBox(height: AppSize.paddingBottom * 3),
              CircleAvatar(
                backgroundImage: AssetImage(AppAssets.companyprofiledb),
                radius: 60,
              ),
              SizedBox(height: AppSize.paddingBottom * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Personal Information',
                  ),
                  GestureDetector(
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
                      child: Icon(Icons.edit))
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.blueColor),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: "Company Name:"),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(text: "Email:"),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(text: "Phone Number:"),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(text: "Location:"),
                        ],
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: '${loggedinUser.companyname}',
                            fontColor: AppColors.blueColor,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                            text: '${loggedinUser.email}',
                            fontColor: AppColors.blueColor,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                            text: '${loggedinUser.mobileno}',
                            fontColor: AppColors.blueColor,
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          CustomText(
                            text: '${loggedinUser.location}',
                            fontColor: AppColors.blueColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
