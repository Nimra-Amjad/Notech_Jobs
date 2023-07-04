import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;
import 'package:notech_mobile_app/model/candidate_model.dart' as cmodel;

import '../../../../model/recruiter_model.dart';
import '../dashboard.dart';

class MCQScreen extends StatefulWidget {
  final String uid1;
  final String uid2;

  MCQScreen({required this.uid1, required this.uid2});

  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  List<JobsMcqs>? mcqs;
  int currentQuestionIndex = 0;
  int totalMarks = 0;
  String? selectedAnswer;
  bool showNextButton = false;
  bool quizFinished = false;

  @override
  void initState() {
    super.initState();
    loadMCQs();
    getdata();
  }

  void loadMCQs() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid1)
              .collection('jobs')
              .doc(widget.uid2)
              .get();

      if (documentSnapshot.exists) {
        Map<String, dynamic>? data = documentSnapshot.data();
        if (data != null) {
          List<dynamic>? mcqList = data['mcqs'];

          if (mcqList != null) {
            List<JobsMcqs> loadedMCQs = mcqList
                .map<JobsMcqs>((mcqData) => JobsMcqs.fromMap(mcqData))
                .toList();
            setState(() {
              mcqs = loadedMCQs;
              currentQuestionIndex = 0;
              totalMarks = 0;
              quizFinished = false;
            });
          }
        }
      }
    } catch (error) {
      // Handle the error appropriately, such as displaying an error message.
      print('Error loading MCQs: $error');
    }
  }

  ///<------------------------------Get Loggedin User Data------------------------------>
  cmodel.Candidate loggedinUser = cmodel.Candidate();
  User? user = FirebaseAuth.instance.currentUser;
  Future<void> getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    setState(() {
      loggedinUser = cmodel.Candidate.fromSnap(snap);
      print("000000000000000000000");
      print(loggedinUser.resumeTitle);
      print("000000000000000000000");
    });
  }

  void selectAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      showNextButton = true;
    });
  }

  void apply(String uid1, String uid2) async {
    // Check if the user has passed the test
    bool passedTest = totalMarks >= (mcqs!.length / 2);
    // bool failedTest = totalMarks >= (mcqs!.length / 2);

    if (passedTest) {
      model.Applicants appl = model.Applicants(
        resumeTitle: loggedinUser.resumeTitle,
        yearsOfExperience: loggedinUser.yearsOfExperience,
        candidate_name: loggedinUser.username,
        candidate_email: loggedinUser.email,
        candidate_mobilenumber: loggedinUser.mobileno,
        candidate_skills: loggedinUser.skills,
        candidate_educations: loggedinUser.educations,
        candidate_experience: loggedinUser.experience,
        userid: loggedinUser.uid,
      );
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid1)
          .collection("jobs")
          .doc(uid2)
          .update({
        "applicants": FieldValue.arrayUnion([appl.toJson()]),
        "applicantsUID": FieldValue.arrayUnion([loggedinUser.uid]),
      });

      print(loggedinUser.resumeTitle);
      print(uid1);
      print(uid2);
    } else if (!passedTest) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid1)
          .collection("jobs")
          .doc(uid2)
          .update({
        "failedapplicantsUID": FieldValue.arrayUnion([loggedinUser.uid])
      });
    }
  }

  void goToNextQuestion() {
    setState(() {
      currentQuestionIndex++;
      selectedAnswer = null;
      showNextButton = false;

      if (currentQuestionIndex >= mcqs!.length) {
        quizFinished = true;

        // Call the apply method here
        apply(widget.uid1, widget.uid2);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (mcqs == null || mcqs!.isEmpty) {
      return Scaffold(
        body: Center(
          child: Text('No MCQs loaded.'),
        ),
      );
    }

    if (quizFinished) {
      bool passed = totalMarks >= (mcqs!.length / 2);
      return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CandidateDashboardScreen()));
          return false;
        },
        child: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                passed
                    ? 'Your Resume has submitted'
                    : 'You have failed the test',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 10),
              Text(
                'Total Marks: $totalMarks',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      );
    }

    JobsMcqs currentMCQ = mcqs![currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('MCQs Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              currentMCQ.question ?? '',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ...currentMCQ.options!.map((option) {
              bool isSelected = option == selectedAnswer;
              return ElevatedButton(
                onPressed: () {
                  selectAnswer(option);
                },
                style: ButtonStyle(
                  backgroundColor: isSelected
                      ? MaterialStateProperty.all(Colors.green)
                      : null,
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : null,
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),
            if (showNextButton)
              ElevatedButton(
                onPressed: () {
                  if (selectedAnswer == currentMCQ.correctAnswer) {
                    setState(() {
                      totalMarks++;
                    });
                  }
                  goToNextQuestion();
                },
                child: Text('Next'),
              ),
          ],
        ),
      ),
    );
  }
}
