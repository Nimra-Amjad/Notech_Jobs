import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/buttons/custom_button.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/screens/candidate_screens/homepage.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:notech_mobile_app/screens/signup_candidate_recruiter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/text/custom_text.dart';
import '../components/theme/decorations.dart';
import '../components/utils/app_assets.dart';
import '../components/utils/app_size.dart';
import '../components/widgets/custom_icon.dart';
import '../components/widgets/snackbar.dart';
import '../resources/auth_methods.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  Future<void> loginuser() async {
    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordcontroller.text);

    if (res == "successfully loggedin") {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_auth.currentUser!.uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        final role = snapshot['role'];
        if (role == '0') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const RecruiterHomePage()));
        } else if (role == '1') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CandidateHomePage()));
        }
      });
    } else {
      print("Can't login");
    }
    if (res == "successfully loggedin") {
      showSnackBar(context, res, Colors.black);
    } else {
      showSnackBar(context, res, Colors.red);
    }
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignupCandidateRecruiter()));
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  child: Column(
                    children: [
                      Image.asset(
                        AppAssets.login,
                        width: 80.w,
                        height: 40.h,
                      ),
                      CustomText(
                          textAlign: TextAlign.center,
                          text: "User Login",
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.blueColor),
                      SizedBox(
                        height: 1.h,
                      ),
                      CustomText(
                          textAlign: TextAlign.center,
                          text:
                              "Hey, Enter your details to get login to your account",
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          fontColor: AppColors.blueColor),
                      SizedBox(
                        height: 3.h,
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
                          }
                          return null;
                        },
                        cursorColor: AppColors.blueColor,
                        controller: _emailcontroller,
                        autovalidateMode: AutovalidateMode.disabled,
                        keyboardType: TextInputType.emailAddress,
                        decoration: AppDecorations.customTextFieldDecoration(
                            hintText: "Email"),
                      ),
                      SizedBox(height: AppSize.paddingAll),
                      TextFormField(
                        obscureText: hidePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
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
                              padding:
                                  EdgeInsets.only(right: AppSize.paddingAll),
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
                      SizedBox(height: AppSize.paddingAll),
                      Row(
                        children: [
                          Expanded(child: Container()),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10, right: 20.0),
                            child: GestureDetector(
                              onTap: () {},
                              child: CustomText(
                                  text: "Forgot Password?",
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal,
                                  fontColor: AppColors.blueColor),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      CustomButton(
                          text: "Login",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              loginuser();
                            }
                          }),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                              text: "Don't have an account? ",
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal,
                              fontColor: AppColors.primaryGrey),
                          GestureDetector(
                            onTap: navigateToSignUp,
                            child: CustomText(
                                text: "Create",
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                fontColor: AppColors.blueColor),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
