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
  List<dynamic>? skills;
  JobPosted({
    this.id,
    this.jobtitle,
    this.jobdes,
    this.jobtype,
    this.yearsrequired,
    this.uid,
    this.applicants,
    this.skills,
  });

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
      skills: snapshot["skills"],
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
        "skills": skills,
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

///<-------------------------------Applicants Model--------------------------------->
class Applicants {
  int? yearsOfExperience;
  String? resumeTitle;
  final String? candidate_name;
  List<dynamic>? candidate_skills;
  List<dynamic>? candidate_educations;
  List<dynamic>? candidate_experience;
  Applicants(
      {this.yearsOfExperience,
      this.resumeTitle,
      this.candidate_name,
      this.candidate_skills,
      this.candidate_educations,
      this.candidate_experience});

  static Applicants fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Applicants(
      resumeTitle: snapshot["resumeTitle"],
      yearsOfExperience: snapshot["yearsOfExperience"],
      candidate_name: snapshot['candidate_name'],
      candidate_skills: snapshot['candidate_skills'],
      candidate_educations: snapshot['candidate_educations'],
      candidate_experience: snapshot['candidate_experience'],
    );
  }

  Map<String, dynamic> toJson() => {
        "yearsOfExperience": yearsOfExperience,
        "resumeTitle": resumeTitle,
        "candidate_name": candidate_name,
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
