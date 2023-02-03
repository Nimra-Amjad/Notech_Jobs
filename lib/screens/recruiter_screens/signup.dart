import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/widgets/custom_text.dart';
import '../../components/widgets/rounded_back_button.dart';
import '../../components/widgets/snackbar.dart';
import '../../components/widgets/textbutton.dart';
import '../../components/widgets/textformfield.dart';
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
  bool _isloading = false;

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
    setState(() {
      _isloading = true;
    });
    String res = await AuthMethods().signupRecruiter(
        email: _emailcontroller.text,
        companyname: _companynamecontroller.text,
        mobileno: _mobilenocontroller.text,
        password: _passwordcontroller.text,
        location: _locationcontroller.text);
    setState(() {
      _isloading = false;
    });
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
    return Scaffold(
        backgroundColor: AppColors.primaryWhite,
        appBar: AppBar(
          backgroundColor: AppColors.primaryWhite,
          leading: BackButtonRounded(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignupCandidateRecruiter()));
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/recruiter.jpg"),
                  const SizedBox(
                    height: 35,
                  ),
                  CustomText(
                    textAlign: TextAlign.center,
                      text:
                          "Hey, Enter your details to get signup to your account",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      fontColor: AppColors.blueColor),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.length < 3) {
                          return "Too short";
                        }
                        return null;
                      },
                      textEditingController: _companynamecontroller,
                      hintText: "Enter Company Name",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
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
                      textEditingController: _mobilenocontroller,
                      hintText: "Enter Mobile Number",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.length < 3) {
                          return "Too short";
                        }
                        return null;
                      },
                      textEditingController: _locationcontroller,
                      hintText: "Enter Location",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        } else if (value.contains("@")) {
                          return null;
                        } else
                          return "Invalid email address";
                      },
                      textEditingController: _emailcontroller,
                      hintText: "Enter email",
                      textInputType: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldInput(
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
                      isPass: true,
                      textEditingController: _passwordcontroller,
                      hintText: "Enter Passowrd",
                      textInputType: TextInputType.text),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButtonWidget(
                      onpressed: () {
                        if (_formKey.currentState!.validate()) {
                          signUpRecruiter();
                        }
                      },
                      text: _isloading ? "loading..." : "Signup as Recruiter",
                      width: MediaQuery.of(context).size.width,
                      height: 57),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 204, 204, 208),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 36, 22, 222),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
