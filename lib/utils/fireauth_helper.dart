import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FireauthHelper {
  FireauthHelper._();

  static final AuthHelper = FireauthHelper._();

  // Create New User With Email And Password
  Future<String> customLogin(
      {required String email, required String password}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return "User Success To Login";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return "The password provided is too weak";
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return "The account already exists for that email";
      }
    } catch (e) {
      print(e);
    }
    return "Please Enter Invalid Field";
  }

  // Check User Email And Password Valid Or Not
  Future<String> CheckCustomUser(
      {required String email, required String password}) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "User Success To Signup";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return "No user found for that email";
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return "Wrong password provided for that user";
      }
    }
    return "Please Enter Invalid Field";
  }

  // Check User Login Or Not
  bool isLogin()  {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    if (firebaseAuth.currentUser != null) {
      return true;
    } else {
      return false;
    }
  }
}
