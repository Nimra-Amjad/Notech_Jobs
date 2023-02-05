import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notech_mobile_app/model/candidate_model.dart' as model;
import 'package:notech_mobile_app/model/recruiter_model.dart' as model;

class AuthMethods {
  String res = "Some error occured";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  //<---------------------------UPDATE CANDIDATE------------------------->
  Future<void> updateCandidate(username, email, mobileno) async {
    final userCollection = _firestore.collection("users");
    final docref = userCollection.doc(user!.uid);
    try {
      await docref.update({
        'username': username,
        'email': email,
        'mobileno': mobileno,
      });
    } catch (e) {
      print("some error occured");
    }
  }

    //<---------------------------UPDATE RECRUITER------------------------->
  Future<void> updateRecruiter(username, email, mobileno, location) async {
    final userCollection = _firestore.collection("users");
    final docref = userCollection.doc(user!.uid);
    try {
      await docref.update({
        'username': username,
        'email': email,
        'mobileno': mobileno,
        'location': location
      });
    } catch (e) {
      print("some error occured");
    }
  }

  model.JobPosted subcol = model.JobPosted();



  //UPDATE JOB DATA
  Future<void> updatejobdata(id, jobtitle, jobdes, jobtype) async {
    
    final userCollection = _firestore.collection("users");
    final docref = userCollection.doc(user!.uid).collection("jobs").doc(id);
    try {
      await docref.update({
        'jobtitle': jobtitle,
        'jobdes': jobdes,
        'jobtype': jobtype,
      });
    } catch (e) {
      print("some error occured");
    }
  }

 

  //SIGN UP RECRUITER
  Future<String> signupRecruiter({
    required String email,
    required String companyname,
    required String mobileno,
    required String location,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          companyname.isNotEmpty ||
          mobileno.isNotEmpty ||
          location.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to our database
        model.Recruiter user = model.Recruiter(
            role: "0",
            companyname: companyname,
            uid: cred.user!.uid,
            email: email,
            mobileno: mobileno,
            location: location);

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Account created successfully";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        res = "Email is already in use on different account";
      }
    }
    return res;
  }

  //SIGN UP CANDIDATE
  Future<String> signupCandidate({
    required String email,
    required String username,
    required String mobileno,
    required String password,
  }) async {
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          mobileno.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        print(cred.user!.uid);

        //add user to our database
        model.Candidate user = model.Candidate(
          role: "1",
          username: username,
          uid: cred.user!.uid,
          email: email,
          mobileno: mobileno,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
        res = "Account created successfully";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        res = "Email is already in use on different account";
      }
    }
    return res;
  }

  //LOG IN USER
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "successfully loggedin";
      } else {
        res = "Please enter all fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        res = "Wrong password entered";
      } else if (e.code == 'user-not-found') {
        res = "User not found\nPlease enter correct email";
      }
      return res;
    }
    return res;
  }
}
