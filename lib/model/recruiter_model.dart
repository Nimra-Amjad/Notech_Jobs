import 'package:cloud_firestore/cloud_firestore.dart';

class Recruiter {
  String? role = "0";
  String? uid;
  String? companyname;
  String? email;
  String? mobileno;
  String? location;
  // Map<String,int>? jobs;
  // String? jobtitle1;
  // String? jobdescription1;
  // String? jobtitle1type;
  // String? jobtitle2;
  // String? jobdescription2;
  // String? jobtitle2type;

  Recruiter({
    this.role,
    this.uid,
    this.companyname,
    this.email,
    this.mobileno,
    this.location,
    // this.jobs,
    // this.jobtitle1,
    // this.jobdescription1,
    // this.jobtitle1type,
    // this.jobtitle2,
    // this.jobdescription2,
    // this.jobtitle2type
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
      // jobs: snapshot['jobs']
      // jobtitle1: snapshot["jobtitle1"],
      // jobdescription1: snapshot["jobdescription1"],
      // jobtitle1type: snapshot["jobtitle1type"],
      // jobtitle2: snapshot["jobtitle2"],
      // jobdescription2: snapshot["jobdescription2"],
      // jobtitle2type: snapshot["jobtitle2type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "uid": uid,
        "email": email,
        "companyname": companyname,
        "mobileno": mobileno,
        'location': location,
        // "jobtitle1": jobtitle1 != null ? jobtitle1 : null,
        // "jobdescription1": jobdescription1 != null ? jobdescription1 : null,
        // "jobtitle1type": jobtitle1type != null ? jobtitle1type : null,
        // "jobtitle2": jobtitle2 != null ? jobtitle2 : null,
        // "jobdescription2": jobdescription2 != null ? jobdescription2 : null,
        // "jobtitle2type": jobtitle2type != null ? jobtitle2type : null,
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
  Applicants({this.pdfurl});

  static Applicants fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Applicants(pdfurl: snapshot['pdfurl']);
  }

  Map<String, dynamic> toJson() => {
        "pdfurl": pdfurl,
      };
}

// class Applicants {
//   String? id;
//   String? cv;

//   Applicants({this.id, this.cv});

//   static Applicants fromSnap(DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return Applicants(id: snapshot['id'], cv: snapshot['cv']);
//   }

//   Map<String, dynamic> toJson() => {"id": id, "cv": cv};
// }
