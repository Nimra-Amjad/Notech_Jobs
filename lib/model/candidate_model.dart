import 'package:cloud_firestore/cloud_firestore.dart';

class Candidate {
  String? role = "1";
  String? uid;
  String? username;
  String? email;
  String? mobileno;
  String? pdfurl;
  String? pdfname;
  String? pdftext;

  Candidate(
      {this.role,
      this.uid,
      this.username,
      this.email,
      this.mobileno,
      this.pdfurl,
      this.pdfname,
      this.pdftext});

  static Candidate fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Candidate(
        role: snapshot["role"],
        uid: snapshot["uid"],
        username: snapshot["username"],
        email: snapshot["email"],
        mobileno: snapshot["mobileno"],
        pdfurl: snapshot["pdfurl"],
        pdfname: snapshot["pdfname"],
        pdftext: snapshot["pdftext"]);
  }

  Map<String, dynamic> toJson() => {
        "role": role,
        "uid": uid,
        "email": email,
        "username": username,
        "mobileno": mobileno,
        "pdfurl": pdfurl != null ? pdfurl : null,
        "pdfname": pdfname != null ? pdfname : null,
        "pdftext": pdftext != null ? pdftext : null
      };
}
