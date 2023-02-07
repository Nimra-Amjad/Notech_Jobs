import '../model/question_model.dart';

List<QuestionModel> questions = [
  QuestionModel(
    "'OS' computer abbreviation usually means?",
    {
      "Order of Significance": false,
      "Open Software": false,
      "Operating System": true,
      "Optical Sensor": false,
    },
  ),
  QuestionModel("Android is", {
    "an operating system": false,
    "a web browser": false,
    "a web server": false,
    "None of the above": true,
  }),
  QuestionModel("Under which of the following Android is licensed?", {
    "OSS": false,
    "Sourceforge": false,
    "Apache/MIT": true,
    "None of the above": false,
  }),
  QuestionModel(
      "Which of the following virtual machine is used by the Android operating system?",
      {
        "JVM": false,
        "Dalvik virtual machine": true,
        "Simple virtual machine": false,
        "None of the above": false,
      }),
  QuestionModel("Android is based on which of the following language?", {
    "Java": true,
    "C++": false,
    "C": false,
    "None of the above": false,
  }),
  QuestionModel("APK stands for -", {
    "Android Phone Kit": false,
    "Android Page Kit": false,
    "Android Package Kit": true,
    "None of the above": false,
  }),
  QuestionModel("What does API stand for?", {
    "Application Programming Interface": true,
    "Android Programming Interface": false,
    "Android Page Interface": false,
    "Application Page Interface": false,
  }),
];
