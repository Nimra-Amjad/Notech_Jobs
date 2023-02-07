import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/app_assets.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/text/custom_text.dart';
import '../../components/buttons/rounded_back_button.dart';
import '../../components/theme/decorations.dart';
import '../../components/utils/app_size.dart';
import '../../components/widgets/custom_icon.dart';
import '../../components/widgets/snackbar.dart';
import '../../resources/auth_methods.dart';
import '../login.dart';
import '../signup_candidate_recruiter.dart';

class RecruiterSignUpPage extends StatefulWidget {
  const RecruiterSignUpPage({super.key});

  @override
  State<RecruiterSignUpPage> createState() => _RecruiterSignUpPageState();
}

class _RecruiterSignUpPageState extends State<RecruiterSignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _mobilenocontroller = TextEditingController();
  final TextEditingController _companynamecontroller = TextEditingController();
  final TextEditingController _locationcontroller = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _mobilenocontroller.dispose();
    _companynamecontroller.dispose();
    _locationcontroller.dispose();
  }

  void signUpRecruiter() async {
    String res = await AuthMethods().signupRecruiter(
        email: _emailcontroller.text,
        companyname: _companynamecontroller.text,
        mobileno: _mobilenocontroller.text,
        password: _passwordcontroller.text,
        location: _locationcontroller.text);

    if (res != "Account created successfully") {
      print("error occured");
      showSnackBar(context, res, Colors.red);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const RecruiterHomePage()));
      showSnackBar(context, res, Colors.black);
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
        body: SafeArea(
          child: Column(
              children: [
          Padding(
            padding: EdgeInsets.only(left: 12.sp),
            child: Align(
              alignment: Alignment.centerLeft,
              child: BackButtonRounded(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          SizedBox(height: AppSize.paddingAll),
          Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.recruiterSignup),
                    CustomText(
                        textAlign: TextAlign.center,
                        text:
                            "Hey, Enter your details to get signup to your account",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.blueColor),
                    SizedBox(
                      height: 2.h,
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
                            padding: EdgeInsets.only(left: AppSize.paddingAll),
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
                            padding: EdgeInsets.only(left: AppSize.paddingAll),
                            child: CustomIcon(
                              icon: Icons.maps_home_work_outlined,
                              iconColor: AppColors.blueColor,
                              iconSize: AppSize.iconSize,
                            ),
                          ),
                          hintText: "Location"),
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
                      obscureText: hidePassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.length < 6) {
                          return "Password should be atleast 6 characters";
                        } else if (value.length > 15) {
                          return "Password should not be greater than 15 characters";
                        } else
                          return null;
                      },
                      cursorColor: AppColors.blueColor,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: _passwordcontroller,
                      cursorHeight: AppSize.textSize * 1.2,
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: AppSize.textSize * 1.2,
                      ),
                      decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Password",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: AppSize.paddingAll),
                          child: CustomIcon(
                            icon: Icons.lock_outlined,
                            iconColor: AppColors.blueColor,
                            iconSize: AppSize.iconSize,
                          ),
                        ),
                        suffixIcon: IconButton(
                            padding: EdgeInsets.only(right: AppSize.paddingAll),
                            iconSize: AppSize.iconSize,
                            onPressed: () {
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: CustomIcon(
                              icon: hidePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              iconColor: AppColors.primaryGrey,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    CustomButton(
                        text: "Signup as Recruiter",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUpRecruiter();
                          }
                        }),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                            text: "Already have an account? ",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            fontColor: AppColors.primaryGrey),
                        GestureDetector(
                          onTap: navigateToLogin,
                          child: CustomText(
                              text: "Login",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              fontColor: AppColors.blueColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
              ],
            ),
        ));
  }
}
