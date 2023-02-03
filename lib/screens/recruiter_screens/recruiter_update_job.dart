import 'package:flutter/material.dart';
import 'package:notech_mobile_app/components/utils/colors.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';

import '../../components/widgets/textformfield.dart';
import '../../resources/auth_methods.dart';

class RecruiterJobUpdate extends StatefulWidget {
  final model.JobPosted user;
  const RecruiterJobUpdate({super.key, required this.user});

  @override
  State<RecruiterJobUpdate> createState() => _RecruiterJobUpdateState();
}

class _RecruiterJobUpdateState extends State<RecruiterJobUpdate> {
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
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          const Text(
            "Update Job Detail",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 36, 22, 222),
              fontSize: 30,
            ),
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
                } else {
                  return null;
                }
              },
              textEditingController: _jobtitlecontroller,
              hintText: "Enter Job Title",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          TextFieldInput(
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                } else {
                  return null;
                }
              },
              textEditingController: _jobdescontroller,
              hintText: "Enter Job Description",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          TextFieldInput(
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                } else {
                  return null;
                }
              },
              textEditingController: _jobtypecontroller,
              hintText: "Enter Job Type",
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 40,
              child: TextButton(
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 36, 22, 222),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: updatejobdata,
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
    );
  }
}
