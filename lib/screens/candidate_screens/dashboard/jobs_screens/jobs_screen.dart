import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/candidate_model.dart';
import 'package:notech_mobile_app/screens/candidate_screens/dashboard/jobs_screens/specific_job_detail_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/model/candidate_model.dart' as model;

import '../../../../components/text/custom_text.dart';
import '../../../../components/theme/decorations.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../components/utils/app_size.dart';
import '../candidate_quiz/quiz.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({super.key});

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  final TextEditingController _searchcontroller = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    // getAllJobs();
    getallCandidateSkills();
    getdata();
  }

  model.Candidate loggedinUser = model.Candidate();
  List<dynamic> job_required_skills = [];
  List<dynamic> job_match = [];

  //<---------------------------------Get All Jobs--------------------------------------------->
  List<dynamic> allJobs = [];
  Future<void> getAllJobs() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await firestore.collectionGroup('jobs').get();
    List<DocumentSnapshot> documents = querySnapshot.docs;
    job_match.clear();
    for (DocumentSnapshot document in documents) {
      // allJobs.add(document.data());

      job_required_skills = document["skills"]
          .toSet()
          .intersection(candidateSkills.toSet())
          .toList();
      print('//////////////////////////////');
      print(job_required_skills.toString());
      print('//////////////////////////////');

      if (job_required_skills.isNotEmpty) {
        job_match.add(document.data());
        print(job_match);
      }
    }
    // print(allJobs);
  }

  //<---------------------------------Get Candidate Skills--------------------------------------------->
  List candidateSkills = [];
  void getallCandidateSkills() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get()
        .then((value) {
      setState(() {
        candidateSkills = value['skills'];
      });
      // print('//////////////////////////////');
      // print(candidateSkills);
      // print('//////////////////////////////');
    });
  }

  ///<------------------------------Get Loggedin User Data------------------------------>

  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      loggedinUser = model.Candidate.fromSnap(snap);
    });
  }

  ///<------------------------------Candidate apply to jobs------------------------------>

  apply(String uid1, String uid2) async {
    model.Applicants appl = model.Applicants(
        resumeTitle: loggedinUser.resumeTitle,
        userid: loggedinUser.uid,
        yearsOfExperience: loggedinUser.yearsOfExperience,
        candidate_name: loggedinUser.username,
        candidate_skills: loggedinUser.skills,
        candidate_educations: loggedinUser.educations,
        candidate_experience: loggedinUser.experience);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid1)
        .collection("jobs")
        .doc(uid2)
        .update({
      "applicants": FieldValue.arrayUnion([appl.toJson()])
    });
    print(uid1);
    print(uid2);
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => CandidateJobApply()));
  }

  @override
  Widget build(BuildContext context) {
    getAllJobs();
    AppSize().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'All Jobs',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        child: Column(
          children: [
            SizedBox(
              height: AppSize.paddingAll,
            ),
            TextFormField(
              cursorHeight: AppSize.textSize * 1.2,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: AppSize.textSize * 1.2,
              ),
              cursorColor: AppColors.blueColor,
              controller: _searchcontroller,
              autovalidateMode: AutovalidateMode.disabled,
              keyboardType: TextInputType.emailAddress,
              decoration: AppDecorations.customTextFieldDecoration(
                  hintText: "Search Jobs"),
            ),
            SizedBox(
              height: AppSize.paddingAll,
            ),
            Expanded(
                child: Container(
              child: FutureBuilder(
                  future: getAllJobs(),
                  builder: (context, AsyncSnapshot snapshot) {
                    return job_match.isEmpty
                        ? CircularProgressIndicator()
                        : StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collectionGroup("jobs")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? ListView.builder(
                                      itemCount: job_match.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        DocumentSnapshot jobs =
                                            snapshot.data!.docs[index];
                                        print(job_match.length);

                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        JobDetailScreen(
                                                            jobTitle: job_match[
                                                                    index]
                                                                ["jobtitle"],
                                                            jobDescription:
                                                                job_match[index]
                                                                    ["jobdes"],
                                                            jobType:
                                                                job_match[index]
                                                                    ["jobtype"],
                                                            requiredskills:
                                                                job_match[index]
                                                                    [
                                                                    "skills"])));
                                          },
                                          child: Card(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                      text:
                                                          '${job_match[index]["jobtitle"]}',
                                                      fontSize: 17.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontColor:
                                                          AppColors.blueColor),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: 6.sp),
                                                    width: 80.w,
                                                    child: CustomText(
                                                        text:
                                                            '${job_match[index]["jobdes"]}',
                                                        fontSize: 15.sp,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontColor: AppColors
                                                            .quizbluecolor),
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  CustomText(
                                                      text: "Posted 1 min ago",
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontColor: AppColors
                                                          .primaryBlack),
                                                  const Divider(
                                                    thickness: 0.5,
                                                    height: 20.0,
                                                    color: Colors.grey,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      apply(jobs['uid'],
                                                          jobs['id']);
                                                      print(jobs['uid']);
                                                      // Navigator.push(
                                                      //     context,
                                                      //     MaterialPageRoute(
                                                      //         builder: (context) =>
                                                      //             MCQScreen(
                                                      //                 uid1: jobs[
                                                      //                     'uid'],
                                                      //                 uid2: jobs[
                                                      //                     'id'])));
                                                    },
                                                    child: Container(
                                                      width: 150,
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .blueLight,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      12)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: const [
                                                          Text(
                                                            "Apply Now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_upward_outlined,
                                                            color: Colors.white,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        // return Text('${jobs_match}');
                                      })
                                  : const CircularProgressIndicator();
                            });
                  }),
            ))
          ],
        ),
      )),
    );
  }
}
