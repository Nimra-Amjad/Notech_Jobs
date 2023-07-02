import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/dashboard.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import '../../components/buttons/rounded_back_button.dart';
import '../../components/buttons/custom_button.dart';
import '../../components/theme/decorations.dart';
import '../../components/utils/app_assets.dart';
import '../../components/utils/app_size.dart';
import '../../components/widgets/custom_icon.dart';
import '../../components/widgets/snackbar.dart';
import '../../resources/auth_methods.dart';
import '../login.dart';

class CandidateSignUpPage extends StatefulWidget {
  const CandidateSignUpPage({super.key});

  @override
  State<CandidateSignUpPage> createState() => _CandidateSignUpPageState();
}

class _CandidateSignUpPageState extends State<CandidateSignUpPage> {
  String res = "Some error occured";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _mobilenocontroller = TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();
  bool hidePassword = true;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _mobilenocontroller.dispose();
    _usernamecontroller.dispose();
  }

  void signUpCandidate() async {
    String res = await AuthMethods().signupCandidate(
      email: _emailcontroller.text,
      username: _usernamecontroller.text,
      mobileno: _mobilenocontroller.text,
      password: _passwordcontroller.text,
    );

    if (res != "Account created successfully") {
      print("error occured");
      showSnackBar(context, res, Colors.red);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const CandidateDashboardScreen()));
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
      child: SingleChildScrollView(
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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Column(
                  children: [
                    Image.asset(AppAssets.candidateSignup),
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
                        text: "Signup as Candidate",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            signUpCandidate();
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
          ],
        ),
      ),
    ));
  }
}
