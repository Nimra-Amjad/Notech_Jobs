import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';
import 'package:notech_mobile_app/screens/candidate_screens/homepage.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:notech_mobile_app/screens/signup_candidate_recruiter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../components/widgets/custom_text.dart';
import '../components/widgets/snackbar.dart';
import '../components/widgets/textbutton.dart';
import '../components/widgets/textformfield.dart';
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
  bool _isloading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User currentuser;

  @override
  void dispose() {
    super.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  Future<void> loginuser() async {
    setState(() {
      _isloading = true;
    });
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
      setState(() {
        _isloading = false;
      });
    } else {
      print("Can't login");
      setState(() {
        _isloading = false;
      });
    }
    if (res == "successfully loggedin") {
      showSnackBar(context, res, Colors.black);
    } else {
      showSnackBar(context, res, Colors.red);
    }
  }

  // Future<void> logincandidate() async {
  //   setState(() {
  //     _isloading = true;
  //   });
  //   String res = await AuthMethods().loginUser(
  //       email: _emailcontroller.text, password: _passwordcontroller.text);

  //   if (res == "successfully loggedin") {
  //     await FirebaseFirestore.instance
  //         .collection("candidate")
  //         .doc(_auth.currentUser!.uid)
  //         .get()
  //         .then((DocumentSnapshot snapshot) {
  //       // final role = snapshot['role'];
  //       // if (role == '0') {
  //       //   Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       //       builder: (context) => const RecruiterHomePage()));
  //       // } else if (role == '1') {
  //         Navigator.of(context).pushReplacement(MaterialPageRoute(
  //             builder: (context) => const CandidateHomePage()));
  //       // }
  //     });
  //     setState(() {
  //       _isloading = false;
  //     });
  //   } else {
  //     print("Can't login");
  //     setState(() {
  //       _isloading = false;
  //     });
  //   }
  //   if (res == "successfully loggedin") {
  //     showSnackBar(context, res, Colors.black);
  //   } else {
  //     showSnackBar(context, res, Colors.red);
  //   }
  // }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const SignupCandidateRecruiter()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryWhite,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/login.png",
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                        textAlign: TextAlign.center,
                        text: "User Login",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        fontColor: AppColors.blueColor),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                        textAlign: TextAlign.center,
                        text:
                            "Hey, Enter your details to get login to your account",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.blueColor),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldInput(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "* Required";
                          }
                          return null;
                        },
                        textEditingController: _emailcontroller,
                        hintText: "Enter your email",
                        textInputType: TextInputType.emailAddress),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFieldInput(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "* Required";
                        }
                        return null;
                      },
                      textEditingController: _passwordcontroller,
                      hintText: "Enter your passowrd",
                      textInputType: TextInputType.text,
                      isPass: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 20.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: Color.fromARGB(255, 36, 22, 222),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButtonWidget(
                        onpressed: () {
                          if (_formKey.currentState!.validate()) {
                            loginuser();
                          }
                        },
                        text: _isloading ? "loading..." : "Login",
                        width: MediaQuery.of(context).size.width,
                        height: 60),
                    //     const SizedBox(
                    //   height: 10,
                    // ),
                    // TextButtonWidget(
                    //     onpressed: () {
                    //       if (_formKey.currentState!.validate()) {
                    //         loginrecruiter();
                    //       }
                    //     },
                    //     text: _isloading ? "loading..." : "Login as Recruiter",
                    //     width: MediaQuery.of(context).size.width,
                    //     height: 60),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don\'t have an account?",
                          style: TextStyle(
                            color: Color.fromARGB(255, 204, 204, 208),
                          ),
                        ),
                        GestureDetector(
                          onTap: navigateToSignUp,
                          child: const Text(
                            "Create",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 36, 22, 222),
                            ),
                          ),
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
        ));
  }
}
