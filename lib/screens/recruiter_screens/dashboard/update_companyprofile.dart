import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/dashboard/company_profile_screen.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../components/buttons/rounded_back_button.dart';
import '../../../components/buttons/custom_button.dart';
import '../../../components/theme/decorations.dart';
import '../../../components/utils/app_size.dart';
import '../../../components/widgets/custom_icon.dart';
import '../../../resources/auth_methods.dart';

class RecruiterUpdatePage extends StatefulWidget {
  final model.Recruiter user;
  const RecruiterUpdatePage({super.key, required this.user});

  @override
  State<RecruiterUpdatePage> createState() => _RecruiterUpdatePageState();
}

class _RecruiterUpdatePageState extends State<RecruiterUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _companynamecontroller = TextEditingController();
  TextEditingController _locationcontroller = TextEditingController();
  bool _isloading = false;

  @override
  void initState() {
    _emailcontroller = TextEditingController(text: widget.user.email);
    _mobilenocontroller = TextEditingController(text: widget.user.mobileno);
    _companynamecontroller =
        TextEditingController(text: widget.user.companyname);
    _locationcontroller = TextEditingController(text: widget.user.location);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _mobilenocontroller.dispose();
    _companynamecontroller.dispose();
    _locationcontroller.dispose();
  }

  void updaterecruiterdata() async {
    await AuthMethods()
        .updateRecruiter(_companynamecontroller.text, _emailcontroller.text,
            _mobilenocontroller.text, _locationcontroller)
        .then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CompanyProfileScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => CompanyProfileScreen()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppSize.paddingAll),
                Align(
                  alignment: Alignment.centerLeft,
                  child: BackButtonRounded(
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(height: AppSize.paddingAll),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        CustomText(
                            textAlign: TextAlign.center,
                            text: "Update Recruiter Detail",
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.blueColor),
                        SizedBox(
                          height: 6.h,
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
                          controller: _companynamecontroller,
                          autovalidateMode: AutovalidateMode.disabled,
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppDecorations.customTextFieldDecoration(
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: AppSize.paddingAll),
                                child: CustomIcon(
                                  icon: Icons.person_2_outlined,
                                  iconColor: AppColors.blueColor,
                                  iconSize: AppSize.iconSize,
                                ),
                              ),
                              hintText: "Company Name"),
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
                                padding:
                                    EdgeInsets.only(left: AppSize.paddingAll),
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
                            } else if (value.length < 3) {
                              return "Too short";
                            }
                            return null;
                          },
                          cursorColor: AppColors.blueColor,
                          controller: _locationcontroller,
                          autovalidateMode: AutovalidateMode.disabled,
                          keyboardType: TextInputType.emailAddress,
                          decoration: AppDecorations.customTextFieldDecoration(
                              prefixIcon: Padding(
                                padding:
                                    EdgeInsets.only(left: AppSize.paddingAll),
                                child: CustomIcon(
                                  icon: Icons.maps_home_work_outlined,
                                  iconColor: AppColors.blueColor,
                                  iconSize: AppSize.iconSize,
                                ),
                              ),
                              hintText: "Location"),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                            text: "Update",
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                updaterecruiterdata();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
