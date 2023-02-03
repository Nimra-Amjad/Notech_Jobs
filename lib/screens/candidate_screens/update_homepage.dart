import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';
import 'package:notech_mobile_app/screens/candidate_screens/homepage.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/widgets/custom_text.dart';
import '../../components/widgets/rounded_back_button.dart';
import '../../components/widgets/textformfield.dart';
import '../../resources/auth_methods.dart';

class CandidateUpdatePage extends StatefulWidget {
  final model.Candidate candidate;
  const CandidateUpdatePage({super.key, required this.candidate});

  @override
  State<CandidateUpdatePage> createState() => _CandidateUpdatePageState();
}

class _CandidateUpdatePageState extends State<CandidateUpdatePage> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _mobilenocontroller = TextEditingController();
  TextEditingController _usernamecontroller = TextEditingController();
  bool _isloading = false;

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
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .updateCandidate(_usernamecontroller.text, _mobilenocontroller.text,
            _emailcontroller.text)
        .then((value) {
      setState(() {
        _isloading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const CandidateHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal:12.sp),
              child: Container(
                alignment: Alignment.center,
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0),color: AppColors.blueColor),
                  child: CustomText(
                      text: "Update Candidate Detail",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.primaryWhite)),
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
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z]+|\s"),
                  )
                ],
                textEditingController: _usernamecontroller,
                hintText: "Enter Full Name",
                textInputType: TextInputType.text),
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
                textInputType: TextInputType.number),
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: AppColors.primaryWhite,
                      backgroundColor: AppColors.blueColor,
                      padding: const EdgeInsets.all(16.0),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: updateuserdata,
                  child: _isloading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryWhite,
                          ),
                        )
                      : const Text('Update'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
