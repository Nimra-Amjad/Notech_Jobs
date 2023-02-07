import 'package:cloud_firestore/cloud_firestore.dart';

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

class JobPosted {
  String? id;
  String? jobtitle;
  String? jobdes;
  String? jobtype;
  String? uid;
  List<dynamic>? applicants;
  JobPosted(
      {this.id,
      this.jobtitle,
      this.jobdes,
      this.jobtype,
      this.uid,
      this.applicants});

  static JobPosted fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return JobPosted(
        id: snapshot['id'],
        jobtitle: snapshot['jobtitle'],
        jobdes: snapshot['jobdes'],
        jobtype: snapshot['jobtype'],
        uid: snapshot['uid'],
        applicants: snapshot['applicants']);
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "jobtitle": jobtitle,
        "jobdes": jobdes,
        "jobtype": jobtype,
        "uid": uid,
        "applicants": applicants
      };
}

class Applicants {
  final String? pdfurl;
  final String? pdfname;
  Applicants({
    this.pdfurl,
    this.pdfname,
  });

  static Applicants fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Applicants(
      pdfurl: snapshot['pdfurl'],
      pdfname: snapshot['pdfname'],
    );
  }

  Map<String, dynamic> toJson() => {
        "pdfurl": pdfurl,
        "pdfname": pdfname,
      };
}
