import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/candidate_profile_screen.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/buttons/custom_button.dart';
import '../../../components/text/custom_text.dart';
import '../../../components/buttons/rounded_back_button.dart';
import '../../../components/theme/decorations.dart';
import '../../../components/utils/app_size.dart';
import '../../../components/widgets/custom_icon.dart';
import '../../../resources/auth_methods.dart';

class CandidateUpdatePage extends StatefulWidget {
  final model.Candidate candidate;
  const CandidateUpdatePage({super.key, required this.candidate});

  @override
  State<CandidateUpdatePage> createState() => _CandidateUpdatePageState();
}

class _CandidateUpdatePageState extends State<CandidateUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _emailcontroller = TextEditingController(text: widget.candidate.email);
    _mobilenocontroller =
        TextEditingController(text: widget.candidate.mobileno);
    _usernamecontroller =
        TextEditingController(text: widget.candidate.username);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _mobilenocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void updateuserdata() async {
    await AuthMethods()
        .updateCandidate(_usernamecontroller.text, _mobilenocontroller.text,
            _emailcontroller.text)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CandidateProfileScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryWhite,
        leading: BackButtonRounded(
          onTap: () {
            Navigator.pop(context);
          },
          color: AppColors.primaryWhite,
          bordercolor: AppColors.primaryBlack,
          iconcolor: AppColors.primaryBlack,
        ),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomText(
                      textAlign: TextAlign.center,
                      text: "Update Candidate Detail",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      fontColor: AppColors.blueColor),
                  SizedBox(
                    height: 4.h,
                  ),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value.length < 3) {
                        return "Too short";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[a-zA-Z]+|\s"),
                      )
                    ],
                    cursorColor: AppColors.blueColor,
                    controller: _usernamecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: AppSize.paddingAll),
                          child: CustomIcon(
                            icon: Icons.person_2_outlined,
                            iconColor: AppColors.blueColor,
                            iconSize: AppSize.iconSize,
                          ),
                        ),
                        hintText: "Full Name"),
                  ),
                  SizedBox(height: AppSize.paddingAll),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value.length != 11) {
                        return "Invalid mobile number";
                      }
                      return null;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r"[0-9]"),
                      )
                    ],
                    cursorColor: AppColors.blueColor,
                    controller: _mobilenocontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: AppSize.paddingAll),
                          child: CustomIcon(
                            icon: Icons.phone_outlined,
                            iconColor: AppColors.blueColor,
                            iconSize: AppSize.iconSize,
                          ),
                        ),
                        hintText: "Mobile Number"),
                  ),
                  SizedBox(height: AppSize.paddingAll),
                  TextFormField(
                    cursorHeight: AppSize.textSize * 1.2,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: AppSize.textSize * 1.2,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "* Required";
                      } else if (value.contains("@gmail.com")) {
                        return null;
                      } else
                        return "Invalid email address";
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _emailcontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Email Address"),
                  ),
                  SizedBox(height: 10.h),
                  CustomButton(
                      text: 'Update',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateuserdata();
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
