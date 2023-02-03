import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';
import 'package:notech_mobile_app/components/widgets/custom_text.dart';
import 'package:notech_mobile_app/screens/recruiter_screens/homepage.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/widgets/rounded_back_button.dart';
import '../../components/widgets/textformfield.dart';
import '../../resources/auth_methods.dart';

class RecruiterUpdatePage extends StatefulWidget {
  final model.Recruiter user;
  const RecruiterUpdatePage({super.key, required this.user});

  @override
  State<RecruiterUpdatePage> createState() => _RecruiterUpdatePageState();
}

class _RecruiterUpdatePageState extends State<RecruiterUpdatePage> {
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
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .updateRecruiter(_companynamecontroller.text, _mobilenocontroller.text,
            _emailcontroller.text, _locationcontroller)
        .then((value) {
      setState(() {
        _isloading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RecruiterHomePage()));
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
                      text: "Update Recruiter Detail",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.primaryWhite)),
            ),
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
                hintText: "Enter location",
                textInputType: TextInputType.text),
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
                  onPressed: updaterecruiterdata,
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
