import 'package:cloud_firestore/cloud_firestore.dart';

///<-------------------------------Candidate Model--------------------------------->
class Candidate {
  String? role = "1";
  String? uid;
  String? username;
  String? email;
  String? mobileno;
  int? yearsOfExperience;
  String? resumeTitle;
  List<dynamic>? skills;
  List<dynamic>? educations;
  List<dynamic>? experience;
  List<dynamic>? interviews;

  Candidate(
      {this.role,
      this.uid,
      this.username,
      this.email,
      this.mobileno,
      this.yearsOfExperience,
      this.resumeTitle,
      this.skills,
      this.educations,
      this.experience,
      this.interviews});

  static Candidate fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Candidate(
      role: snapshot["role"],
      uid: snapshot["uid"],
      username: snapshot["username"],
      email: snapshot["email"],
      mobileno: snapshot["mobileno"],
      yearsOfExperience: snapshot["yearsOfExperience"],
      resumeTitle: snapshot["resumeTitle"],
      skills: snapshot["skills"],
      educations: snapshot["educations"],
      experience: snapshot["experience"],
      interviews: snapshot["interviews"],
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "uid": uid,
        "email": email,
        "username": username,
        "mobileno": mobileno,
        "yearsOfExperience": yearsOfExperience,
        "resumeTitle": resumeTitle,
        "skills": skills,
        "educations": educations,
        "experience": experience,
        "interviews": interviews,
      };
}

///<-------------------------------Skills Model--------------------------------->

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

///<-------------------------------Education Model--------------------------------->

class Education {
  final String? qualification;
  final String? passingYear;
  final String? collegeName;
  Education({this.qualification, this.passingYear, this.collegeName});

  static Education fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Education(
      qualification: snapshot['qualification'],
      passingYear: snapshot['passingYear'],
      collegeName: snapshot['collegeName'],
    );
  }

  Map<String, dynamic> toJson() => {
        "qualification": qualification,
        "passingYear": passingYear,
        "collegeName": collegeName,
      };
}

///<-------------------------------Experience Model--------------------------------->

class Experience {
  final String? companyName;
  final String? designation;
  final String? joinDate;
  final String? endDate;
  Experience({this.companyName, this.designation, this.joinDate, this.endDate});

  static Experience fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Experience(
      companyName: snapshot['companyName'],
      designation: snapshot['designation'],
      joinDate: snapshot['joinDate'],
      endDate: snapshot['endDate'],
    );
  }

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "designation": designation,
        "joinDate": joinDate,
        "endDate": endDate,
      };
}

///<-------------------------------Interviews Model--------------------------------->

class Interviews {
  final String? jobtitle;
  final String? date;
  final String? time;
  final String? id;
  Interviews({
    this.jobtitle,
    this.date,
    this.time,
    this.id,
  });

  static Interviews fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Interviews(
      jobtitle: snapshot['jobtitle'],
      date: snapshot['date'],
      time: snapshot['time'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toJson() => {
        "jobtitle": jobtitle,
        "date": date,
        "time": time,
        "id": id,
      };
}
