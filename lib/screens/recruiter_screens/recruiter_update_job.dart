import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/app_colors.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../components/buttons/custom_button.dart';
import '../../components/theme/decorations.dart';
import '../../components/utils/app_size.dart';
import '../../resources/auth_methods.dart';

class RecruiterJobUpdate extends StatefulWidget {
  final model.JobPosted user;
  const RecruiterJobUpdate({super.key, required this.user});

  @override
  State<RecruiterJobUpdate> createState() => _RecruiterJobUpdateState();
}

class _RecruiterJobUpdateState extends State<RecruiterJobUpdate> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _jobtitlecontroller = TextEditingController();
  TextEditingController _jobdescontroller = TextEditingController();
  TextEditingController _jobtypecontroller = TextEditingController();
  bool _isloading = false;

  @override
  void initState() {
    _jobtitlecontroller = TextEditingController(text: widget.user.jobtitle);
    _jobdescontroller = TextEditingController(text: widget.user.jobdes);
    _jobtypecontroller = TextEditingController(text: widget.user.jobtype);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _jobtitlecontroller.dispose();
    _jobdescontroller.dispose();
    _jobtypecontroller.dispose();
  }

  void updatejobdata() async {
    setState(() {
      _isloading = true;
    });
    await AuthMethods()
        .updatejobdata(widget.user.id, _jobtitlecontroller.text,
            _jobdescontroller.text, _jobtypecontroller.text)
        .then((value) {
      setState(() {
        _isloading = false;
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RecruiterJobPost()));
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize().init(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
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
                    controller: _jobtitlecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Job Title"),
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
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _jobdescontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Job Description"),
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
                      }
                      return null;
                    },
                    cursorColor: AppColors.blueColor,
                    controller: _jobtypecontroller,
                    autovalidateMode: AutovalidateMode.disabled,
                    keyboardType: TextInputType.emailAddress,
                    decoration: AppDecorations.customTextFieldDecoration(
                        hintText: "Job Type"),
                  ),
                  SizedBox(height: AppSize.paddingAll),
                  CustomButton(
                      text: "Update",
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          updatejobdata();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
