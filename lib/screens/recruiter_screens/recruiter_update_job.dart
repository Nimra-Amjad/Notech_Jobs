// import 'package:flutter/material.dart';
// import 'package:notech_mobile_app/components/utils/app_colors.dart';
// import 'package:notech_mobile_app/components/widgets/custom_icon.dart';
// import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
// import 'package:notech_mobile_app/screens/recruiter_screens/recruiter_jobposted.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// import '../../components/buttons/custom_button.dart';
// import '../../components/buttons/rounded_back_button.dart';
// import '../../components/text/custom_text.dart';
// import '../../components/theme/decorations.dart';
// import '../../components/utils/app_size.dart';
// import '../../resources/auth_methods.dart';

// class RecruiterJobUpdate extends StatefulWidget {
//   final model.JobPosted user;
//   const RecruiterJobUpdate({super.key, required this.user});

//   @override
//   State<RecruiterJobUpdate> createState() => _RecruiterJobUpdateState();
// }

// class _RecruiterJobUpdateState extends State<RecruiterJobUpdate> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _jobtitlecontroller = TextEditingController();
//   TextEditingController _jobdescontroller = TextEditingController();
//   TextEditingController _jobtypecontroller = TextEditingController();
//   bool _isloading = false;

//   @override
//   void initState() {
//     _jobtitlecontroller = TextEditingController(text: widget.user.jobtitle);
//     _jobdescontroller = TextEditingController(text: widget.user.jobdes);
//     _jobtypecontroller = TextEditingController(text: widget.user.jobtype);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _jobtitlecontroller.dispose();
//     _jobdescontroller.dispose();
//     _jobtypecontroller.dispose();
//   }

//   void updatejobdata() async {
//     setState(() {
//       _isloading = true;
//     });
//     await AuthMethods()
//         .updatejobdata(widget.user.id, _jobtitlecontroller.text,
//             _jobdescontroller.text, _jobtypecontroller.text)
//         .then((value) {
//       setState(() {
//         _isloading = false;
//       });
//       Navigator.push(context,
//           MaterialPageRoute(builder: (context) => const RecruiterJobPost()));
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     AppSize().init(context);
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(height: 2.h),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: BackButtonRounded(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ),
//               SizedBox(height: AppSize.paddingAll),
//               Form(
//                 key: _formKey,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.sp),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 2.h,
//                       ),
//                       CustomText(
//                           textAlign: TextAlign.center,
//                           text: "Update Job",
//                           fontSize: 22.sp,
//                           fontWeight: FontWeight.w600,
//                           fontColor: AppColors.blueColor),
//                       SizedBox(
//                         height: 6.h,
//                       ),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: CustomText(
//                             text: "Job Title : ",
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w500,
//                             fontColor: AppColors.primaryBlack),
//                       ),
//                       SizedBox(height: AppSize.paddingAll),
//                       TextFormField(
//                         cursorHeight: AppSize.textSize * 1.2,
//                         style: TextStyle(
//                           color: AppColors.primaryBlack,
//                           fontSize: AppSize.textSize * 1.2,
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "* Required";
//                           }
//                           return null;
//                         },
//                         cursorColor: AppColors.blueColor,
//                         controller: _jobtitlecontroller,
//                         autovalidateMode: AutovalidateMode.disabled,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: AppDecorations.customTextFieldDecoration(
//                             hintText: "Job Title",
//                             prefixIcon: CustomIcon(
//                                 icon: Icons.edit,
//                                 iconColor: AppColors.blueColor)),
//                       ),
//                       SizedBox(height: AppSize.paddingAll),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: CustomText(
//                             text: "Job Description : ",
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w500,
//                             fontColor: AppColors.primaryBlack),
//                       ),
//                       SizedBox(height: AppSize.paddingAll),
//                       TextFormField(
//                         cursorHeight: AppSize.textSize * 1.2,
//                         style: TextStyle(
//                           color: AppColors.primaryBlack,
//                           fontSize: AppSize.textSize * 1.2,
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "* Required";
//                           }
//                           return null;
//                         },
//                         cursorColor: AppColors.blueColor,
//                         controller: _jobdescontroller,
//                         autovalidateMode: AutovalidateMode.disabled,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: AppDecorations.customTextFieldDecoration(
//                             prefixIcon: CustomIcon(
//                                 icon: Icons.edit,
//                                 iconColor: AppColors.blueColor),
//                             hintText: "Job Description"),
//                       ),
//                       SizedBox(height: AppSize.paddingAll),
//                       Align(
//                         alignment: Alignment.centerLeft,
//                         child: CustomText(
//                             text: "Job Type : ",
//                             fontSize: 18.sp,
//                             fontWeight: FontWeight.w500,
//                             fontColor: AppColors.primaryBlack),
//                       ),
//                       SizedBox(height: AppSize.paddingAll),
//                       TextFormField(
//                         cursorHeight: AppSize.textSize * 1.2,
//                         style: TextStyle(
//                           color: AppColors.primaryBlack,
//                           fontSize: AppSize.textSize * 1.2,
//                         ),
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "* Required";
//                           }
//                           return null;
//                         },
//                         cursorColor: AppColors.blueColor,
//                         controller: _jobtypecontroller,
//                         autovalidateMode: AutovalidateMode.disabled,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: AppDecorations.customTextFieldDecoration(
//                             prefixIcon: CustomIcon(
//                                 icon: Icons.edit,
//                                 iconColor: AppColors.blueColor),
//                             hintText: "Job Type"),
//                       ),
//                       SizedBox(height: 10.h),
//                       CustomButton(
//                           text: "Update",
//                           onTap: () {
//                             if (_formKey.currentState!.validate()) {
//                               updatejobdata();
//                             }
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
