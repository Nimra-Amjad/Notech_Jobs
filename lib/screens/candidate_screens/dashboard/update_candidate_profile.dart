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
import 'create_resume/resume_profile.dart';

class CandidateUpdatePage extends StatefulWidget {
  final String text;
  final model.Candidate candidate;
  const CandidateUpdatePage({Key? key, required this.candidate, required this.text})
      : super(key: key);

  @override
  State<CandidateUpdatePage> createState() => _CandidateUpdatePageState();
}

class _CandidateUpdatePageState extends State<CandidateUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileNoController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    _emailController = TextEditingController(text: widget.candidate.email);
    _mobileNoController =
        TextEditingController(text: widget.candidate.mobileno);
    _usernameController =
        TextEditingController(text: widget.candidate.username);
    print(widget.candidate.email);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _mobileNoController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void updateUserData() async {
    await AuthMethods()
        .updateCandidate(_usernameController.text, _emailController.text,
            _mobileNoController.text)
        .then((value) {
         
    widget.text== "candidateprofile"?  Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CandidateProfileScreen())): Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ResumeProfile()));
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
                    controller: _usernameController,
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
                      } else if (value.contains("@gmail.com")) {
                        return null;
                      } else
                        return "Invalid email address";
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _emailController,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Email Address"),
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
                    controller: _mobileNoController,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.number,
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
                  SizedBox(height: 10.h),
                  CustomButton(
                      text: 'Update',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updateUserData();
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
