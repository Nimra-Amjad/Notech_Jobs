import 'package:cloud_firestore/cloud_firestore.dart';

///<-------------------------------Recruiter Model--------------------------------->
class Recruiter {
  String? role = "0";
  String? uid;
  String? companyname;
  String? email;
  String? mobileno;
  String? location;

  Recruiter({
    this.role,
    this.uid,
    this.companyname,
    this.email,
    this.mobileno,
    this.location,
  });

  static Recruiter fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Recruiter(
      role: snapshot['role'],
      uid: snapshot["uid"],
      companyname: snapshot["companyname"],
      email: snapshot["email"],
      mobileno: snapshot["mobileno"],
      location: snapshot["location"],
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "uid": uid,
        "email": email,
        "companyname": companyname,
        "mobileno": mobileno,
        'location': location,
      };
}

///<-------------------------------Jobposted Model--------------------------------->
class JobPosted {
  String? id;
  String? jobtitle;
  String? jobdes;
  String? jobtype;
  int? yearsrequired;
  String? uid;
  List<dynamic>? applicants;
  List<String>? applicantsUID;
  List<String>? failedapplicantsUID;
  List<dynamic>? skills;
  List<dynamic>? mcqs;
  List<dynamic>? interviews;
  JobPosted(
      {this.id,
      this.jobtitle,
      this.jobdes,
      this.jobtype,
      this.yearsrequired,
      this.uid,
      this.applicants,
      this.applicantsUID,
      this.failedapplicantsUID,
      this.skills,
      this.mcqs,
      this.interviews});

  static JobPosted fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return JobPosted(
      id: snapshot['id'],
      jobtitle: snapshot['jobtitle'],
      jobdes: snapshot['jobdes'],
      jobtype: snapshot['jobtype'],
      yearsrequired: snapshot['yearsrequired'],
      uid: snapshot['uid'],
      applicants: snapshot['applicants'],
      applicantsUID: snapshot['applicantsUID'],
      failedapplicantsUID: snapshot['failedapplicantsUID'],
      skills: snapshot["skills"],
      mcqs: snapshot["mcqs"],
      interviews: snapshot["interviews"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobtitle": jobtitle,
        "jobdes": jobdes,
        "jobtype": jobtype,
        "yearsrequired": yearsrequired,
        "uid": uid,
        "applicants": applicants,
        "applicantsUID": applicantsUID,
        "failedapplicantsUID": failedapplicantsUID,
        "skills": skills,
        "mcqs": mcqs,
        "interviews": interviews
      };
}

///<-------------------------------Interview Model--------------------------------->

class Interviews {
  final String? jobTitle;
  final String? applicantName;
  final String? date;
  final String? time;
  final String? id;
  final String? jobid;
  final String? companyUid;
  final String? userUid;
  Interviews({
    this.jobTitle,
    this.applicantName,
    this.date,
    this.time,
    this.id,
    this.jobid,
    this.companyUid,
    this.userUid,
  });

  static Interviews fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Interviews(
      jobTitle: snapshot['jobTitle'],
      applicantName: snapshot['applicantName'],
      date: snapshot['date'],
      time: snapshot['time'],
      id: snapshot['id'],
      jobid: snapshot['jobid'],
      companyUid: snapshot['companyUid'],
      userUid: snapshot['userUid'],
    );
  }

  Map<String, dynamic> toJson() => {
        "jobTitle": jobTitle,
        "applicantName": applicantName,
        "date": date,
        "time": time,
        "id": id,
        "jobid": jobid,
        "companyUid": companyUid,
        "userUid": userUid
      };
}

///<-------------------------------Skills Required Model--------------------------------->

class Skills {
  final String? skill;
  Skills({
    this.skill,
  });

  static Skills fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Skills(
      skill: snapshot['skill'],
    );
  }

  Map<String, dynamic> toJson() => {
        "skill": skill,
      };
}

///<-------------------------------Applicants UID Model--------------------------------->
// class ApplicantsUID {
//   String? userid;
//   ApplicantsUID({
//     this.userid,
//   });

//   static ApplicantsUID fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return ApplicantsUID(
//       userid: snapshot["userid"],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "userid": userid,
//       };
// }

///<-------------------------------Applicants Model--------------------------------->
class Applicants {
  int? yearsOfExperience;
  String? userid;
  String? resumeTitle;
  final String? candidate_name;
  final String? candidate_email;
  final String? candidate_mobilenumber;
  List<dynamic>? candidate_skills;
  List<dynamic>? candidate_educations;
  List<dynamic>? candidate_experience;
  Applicants(
      {this.yearsOfExperience,
      this.userid,
      this.resumeTitle,
      this.candidate_name,
      this.candidate_email,
      this.candidate_mobilenumber,
      this.candidate_skills,
      this.candidate_educations,
      this.candidate_experience});

  static Applicants fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Applicants(
      resumeTitle: snapshot["resumeTitle"],
      userid: snapshot["userid"],
      yearsOfExperience: snapshot["yearsOfExperience"],
      candidate_name: snapshot['candidate_name'],
      candidate_email: snapshot['candidate_email'],
      candidate_mobilenumber: snapshot['candidate_mobilenumber'],
      candidate_skills: snapshot['candidate_skills'],
      candidate_educations: snapshot['candidate_educations'],
      candidate_experience: snapshot['candidate_experience'],
    );
  }

  Map<String, dynamic> toJson() => {
        "yearsOfExperience": yearsOfExperience,
        "userid": userid,
        "resumeTitle": resumeTitle,
        "candidate_name": candidate_name,
        "candidate_email": candidate_email,
        "candidate_mobilenumber": candidate_mobilenumber,
        "candidate_skills": candidate_skills,
        "candidate_educations": candidate_educations,
        "candidate_experience": candidate_experience
      };
}

///<-------------------------------Candidate Skills Model--------------------------------->

class CandidateSkills {
  final String? candidate_skills;
  CandidateSkills({
    this.candidate_skills,
  });

  static CandidateSkills fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CandidateSkills(
      candidate_skills: snapshot['candidate_skills'],
    );
  }

  Map<String, dynamic> toJson() => {
        "candidate_skills": candidate_skills,
      };
}

///<-----------------------------Jobs Mcqs Model--------------------------------->

class JobsMcqs {
  final String? question;
  final String? correctAnswer;
  List<dynamic>? options;
  JobsMcqs({
    this.question,
    this.correctAnswer,
    this.options,
  });

  static JobsMcqs fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return JobsMcqs(
      question: snapshot['question'],
      correctAnswer: snapshot['correctAnswer'],
      options: snapshot['options'],
    );
  }

  Map<String, dynamic> toJson() => {
        "question": question,
        "correctAnswer": correctAnswer,
        "options": options,
      };

  factory JobsMcqs.fromMap(Map<String, dynamic> map) {
    return JobsMcqs(
      // Assign values from the map to the corresponding fields in the class
      question: map['question'],
      options: List<String>.from(map['options']),
      correctAnswer: map['correctAnswer'],
    );
  }
}

// ///<-----------------------------Mcqs Options Model--------------------------------->

// class McqsOptions {
//   String? options;
//   McqsOptions({
//     this.options,
//   });

//   static McqsOptions fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return McqsOptions(
//       options: snapshot['options'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         "options": options,
//       };
// }

// class MCQ {
//   final String question;
//   final List<String> options;
//   final String correctAnswer;

//   MCQ({
//     required this.question,
//     required this.options,
//     required this.correctAnswer,
//   });

//   factory MCQ.fromMap(Map<String, dynamic> map) {
//     return MCQ(
//       question: map['question'],
//       options: List<String>.from(map['options']),
//       correctAnswer: map['correctAnswerIndex'] ?? 0,
//     );
//   }
// }

///<-------------------------------Candidate Education Model--------------------------------->

class CandidateEducation {
  final String? candidate_education;
  CandidateEducation({
    this.candidate_education,
  });

  static CandidateEducation fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CandidateEducation(
      candidate_education: snapshot['candidate_education'],
    );
  }

  Map<String, dynamic> toJson() => {
        "candidate_education": candidate_education,
      };
}

///<-------------------------------Candidate Experience Model--------------------------------->

class CandidateExperience {
  final String? candidate_experience;
  CandidateExperience({
    this.candidate_experience,
  });

  static CandidateExperience fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return CandidateExperience(
      candidate_experience: snapshot['candidate_experience'],
    );
  }

  Map<String, dynamic> toJson() => {
        "candidate_experience": candidate_experience,
      };
}
