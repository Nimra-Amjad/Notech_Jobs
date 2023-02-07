import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:notech_mobile_app/components/utils/custom_router.dart';
import 'package:notech_mobile_app/components/text/custom_text.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/screens/candidate_screens/candidate_jobapplypage.dart';
import 'package:notech_mobile_app/screens/candidate_screens/candidate_jobpage.dart';
import 'package:notech_mobile_app/screens/candidate_screens/update_homepage.dart';
import 'package:notech_mobile_app/screens/candidate_screens/view_resumepdf.dart';
import 'package:notech_mobile_app/screens/login.dart';
import 'package:notech_mobile_app/screens/notification.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;

import '../../components/utils/app_assets.dart';
import '../../components/utils/app_colors.dart';

class CandidateHomePage extends StatefulWidget {
  const CandidateHomePage({super.key});

  @override
  State<CandidateHomePage> createState() => _CandidateHomePageState();
}

class _CandidateHomePageState extends State<CandidateHomePage> {
  String text = "";
  User? user = FirebaseAuth.instance.currentUser;

  model.Candidate loggedinUser = model.Candidate();
  model.JobPosted jobs = model.JobPosted();
  @override
  void initState() {
    super.initState();
    getdata();
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

  // List<String> alljobs = [];
  // List<String> jobs_match = [];
  // var match;
  // getalljobs() async {
  //   QuerySnapshot feed =
  //       await FirebaseFirestore.instance.collectionGroup('jobs').get();
  //   alljobs.clear();
  //   for (var postDoc in feed.docs) {
  //     model.JobPosted post = model.JobPosted.fromSnap(postDoc);

  //     alljobs.add(post.jobdes.toString());
  //   }
  //   print(alljobs);

  //   jobs_match.clear();
  //   for (String a in alljobs) {
  //     http.Response response = await http.get(Uri.parse(
  //         'https://nimraamjad.pythonanywhere.com/api?querycv=$loggedinUser.pdftext&queryjob=$a'));
  //     match = jsonDecode(response.body);

  //     if (double.parse(match['matching percent']) > 15.0) {
  //       jobs_match.add(a);
  //     }
  //   }
  //   print("0000000000000000000000000000000");
  //   print(jobs_match);
  // }

  ///<------------------------------Pick Resume------------------------------>

  pickpdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    File file = File(result.files.single.path!);
    Uint8List bytes = file.readAsBytesSync();
    String name = result.files.first.name;
    print(file.path);
    print(name);

    //Load an existing PDF document.
    PdfDocument document = PdfDocument(inputBytes: bytes);

    //Create a new instance of the PdfTextExtractor.
    PdfTextExtractor extractor = PdfTextExtractor(document);

    //Extract all the text from the document.
    String extracttext = extractor.extractText();

    setState(() {
      text = extracttext;
    });

    //Display the text.
    print(text);

    // http.Response response = await http.get(Uri.parse(
    //     'https://nimraamjad.pythonanywhere.com/api?querycv=text&queryjob=mobile%20flutter%20developer'));

    // print(response.body);

    //uploading file to firebase storage
    var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
    UploadTask task = pdfFile.putData(bytes);
    TaskSnapshot snapshot = await task;
    String fileurl = await snapshot.ref.getDownloadURL();
    print(fileurl);

    //uploading file to firebase collection
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .update({"pdfurl": fileurl, "pdfname": name, "pdftext": text});
    print(name);
  }

  ///<------------------------------Candidate apply to jobs------------------------------>

  apply(String uid1, String uid2) async {
    model.Applicants appl = model.Applicants(pdfurl: loggedinUser.pdfurl);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid1)
        .collection("jobs")
        .doc(uid2)
        .update({
      "applicants": FieldValue.arrayUnion([appl.toJson()])
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => CandidateJobApply()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: ListTile(
          title: CustomText(
              text: "Notech Jobs",
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.primaryWhite),
          trailing: GestureDetector(
            onTap: () {
              CustomRouter().push(context, NotificationScreen());
            },
            child: const Icon(
              Icons.notifications,
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.homebackground),
                // scale: 1,
                fit: BoxFit.fill)),
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collectionGroup("jobs").snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot jobs = snapshot.data!.docs[index];

                        // getapi(jobs['jobdes']);

                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  jobs['jobtitle'],
                                  style: const TextStyle(
                                      color: AppColors.blueColor),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                Text(
                                  jobs['jobdes'],
                                  style: const TextStyle(
                                      color: AppColors.blueColor),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                const Text(
                                  "Posted 1 min ago",
                                  style: TextStyle(fontSize: 11),
                                ),
                                const Divider(
                                  thickness: 0.5,
                                  height: 20.0,
                                  color: Colors.grey,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    apply(jobs['uid'], jobs['id']);
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.blueColor,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                        Text(
                                          "Apply Now",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Icon(
                                          Icons.arrow_upward_outlined,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      })
                  : const CircularProgressIndicator();
            }),
      ),
      drawer: SafeArea(
        child: Drawer(
          child: RefreshIndicator(
            onRefresh: () => getdata(),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45.sp,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: AppColors.blueLight,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Container(
                        alignment: Alignment.bottomLeft,
                        child: CustomText(
                            text: '${loggedinUser.username}',
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            fontColor: AppColors.primaryWhite)),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CandidateUpdatePage(
                                  candidate: model.Candidate(
                                      username: loggedinUser.username,
                                      email: loggedinUser.email,
                                      mobileno: loggedinUser.mobileno))));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.sp),
                          child: CustomText(
                              text: "Personal Details",
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w400,
                              fontColor: AppColors.blueColor),
                        ),
                        Icon(Icons.edit)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0, right: 6.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppColors.lightGrey,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.email),
                              SizedBox(
                                width: 4.w,
                              ),
                              CustomText(
                                  text: '${loggedinUser.email}',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  fontColor: AppColors.primaryBlack),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.call),
                              SizedBox(
                                width: 4.w,
                              ),
                              CustomText(
                                  text: '${loggedinUser.mobileno}',
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  fontColor: AppColors.primaryBlack),
                            ],
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_city),
                              SizedBox(
                                width: 4.w,
                              ),
                              CustomText(
                                  text: "Drigh Road",
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w400,
                                  fontColor: AppColors.primaryBlack),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp),
                  child: CustomText(
                      text: "Resume",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontColor: AppColors.blueColor),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      loggedinUser.pdfname != null
                          ? GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CandidateViewResume(
                                                filename: loggedinUser.pdfname!,
                                                fileurl:
                                                    loggedinUser.pdfurl!)));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 60.w,
                                height: 5.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22.0),
                                    color: AppColors.lightGrey),
                                child: CustomText(
                                    text: '${loggedinUser.pdfname}',
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.normal,
                                    fontColor: AppColors.quizbluecolor),
                              ))
                          : CustomText(
                              text: "Add Resume",
                              fontSize: 17.sp,
                              fontWeight: FontWeight.normal,
                              fontColor: AppColors.quizbluecolor),
                      GestureDetector(
                          onTap: pickpdf, child: const Icon(Icons.attachment))
                    ],
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 20.0,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CandidateJobPage()));
                  },
                  child: ListTile(
                    title: CustomText(
                        text: "Jobs",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                        fontColor: AppColors.blueColor),
                    leading: Icon(
                      Icons.wallet_membership_rounded,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 20.0,
                  color: Colors.grey,
                ),
                ListTile(
                  title: CustomText(
                      text: "Help",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.normal,
                      fontColor: AppColors.blueColor),
                  leading: Icon(
                    Icons.help,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 20.0,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    // getalljobs();
                  },
                  child: ListTile(
                    title: CustomText(
                        text: "Settings",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                        fontColor: AppColors.blueColor),
                    leading: Icon(
                      Icons.settings,
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 20.0,
                  color: Colors.grey,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: ListTile(
                    title: CustomText(
                        text: "Logout",
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                        fontColor: AppColors.blueColor),
                    leading: Icon(Icons.logout),
                  ),
                ),
                const Divider(
                  thickness: 1,
                  height: 20.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
