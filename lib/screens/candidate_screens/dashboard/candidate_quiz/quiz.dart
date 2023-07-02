import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../components/text/custom_text.dart';
import '../../../../components/utils/app_colors.dart';
import '../../../../model/recruiter_model.dart';

class MCQScreen extends StatefulWidget {
  final String uid1;
  final String uid2;

  MCQScreen({required this.uid1, required this.uid2});

  @override
  _MCQScreenState createState() => _MCQScreenState();
}

class _MCQScreenState extends State<MCQScreen> {
  List<MCQ> mcqs = [];
  int currentIndex = 0;
  Map<int, int> selectedAnswers = {};
  int obtainedMarks = 0;
  double percentage = 0.0;

  @override
  void initState() {
    super.initState();
    loadMCQs();
  }

  void loadMCQs() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.uid1)
        .collection('jobs')
        .doc(widget.uid2)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;
      if (data != null) {
        List<dynamic>? mcqList = data['mcqs'];
        if (mcqList != null) {
          List<MCQ> loadedMCQs =
              mcqList.map((mcqData) => MCQ.fromMap(mcqData)).toList();
          setState(() {
            mcqs = loadedMCQs;
          });
        }
      }
    }
  }

  void selectAnswer(int questionIndex, int optionIndex) {
    setState(() {
      selectedAnswers[questionIndex] = optionIndex;
    });
  }

  void calculateMarks() {
    int totalMarks = mcqs.length;
    obtainedMarks = 0;
    for (var i = 0; i < mcqs.length; i++) {
      if (selectedAnswers.containsKey(i) &&
          selectedAnswers[i] == mcqs[i].correctAnswerIndex) {
        obtainedMarks++;
      }
    }
    setState(() {
      percentage = (obtainedMarks / totalMarks) * 100;
    });
  }

  void goToNextMCQ() {
    setState(() {
      currentIndex++;
    });
  }

  void goToPreviousMCQ() {
    setState(() {
      currentIndex--;
    });
  }

  @override
  Widget build(BuildContext context) {
    int totalMarks = mcqs.length;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blueColor,
        title: CustomText(
          text: 'MCQ\'s',
          fontColor: AppColors.primaryWhite,
        ),
      ),
      body: mcqs.isEmpty
          ? Center(
              child: Text("NOT AVAILABLE"),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${currentIndex + 1}/${mcqs.length}',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    mcqs[currentIndex].question,
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: mcqs[currentIndex].options.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                        title: Text(mcqs[currentIndex].options[index]),
                        value: index,
                        groupValue: selectedAnswers[currentIndex],
                        onChanged: (value) {
                          selectAnswer(currentIndex, value as int);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (currentIndex > 0)
                        ElevatedButton(
                          onPressed: goToPreviousMCQ,
                          child: Text('Previous'),
                        ),
                      if (currentIndex < mcqs.length - 1)
                        ElevatedButton(
                          onPressed: goToNextMCQ,
                          child: Text('Next'),
                        ),
                      if (currentIndex == mcqs.length - 1)
                        ElevatedButton(
                          onPressed: calculateMarks,
                          child: Text('OK'),
                        ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  if (obtainedMarks != 0)
                    Text(
                      'Marks Obtained: $obtainedMarks/$totalMarks',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  if (percentage != 0.0)
                    Text(
                      'Percentage: ${percentage.toStringAsFixed(2)}%',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                ],
              ),
            ),
    );
  }
}
