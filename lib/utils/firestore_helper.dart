import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';

import '../screen/controller/signup_controller.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final firestore = FirestoreHelper._();

  // For Create profile database
  void ProfileData(
      {required String username,
      required String mobile,
      required String profileimg,
      required String aboutme}) {
    FirebaseFirestore.instance
        .collection("profile")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "Username": username,
      "Mobile": mobile,
      "Profileimg": profileimg,
      "Aboutme": aboutme,
      "Email": FirebaseAuth.instance.currentUser!.email,
      "Uid": FirebaseAuth.instance.currentUser!.uid,
      "Keywords": SignupController.Controller.searchsystem(mobile),
    });
  }

  // Read ProfileData Method

  // ignore: non_constant_identifier_names
  Stream<QuerySnapshot<Map<String, dynamic>>> ReadProfile() {
    return FirebaseFirestore.instance.collectionGroup("profile").snapshots();
  }

  // search user for chatting

  Stream<QuerySnapshot<Map<String, dynamic>>> Searchuser(
      String search_keywords) {
    return FirebaseFirestore.instance
        .collection(
          "profile",
        )
        .where("Keywords", arrayContains: search_keywords)
        .where("Email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  // CREATING A NEW CHATROOM FOR USER NAD USER

  void CreateChatroom(
      {required String chatroomid,
      required String lastmessage,
      required Map<String, dynamic> participents}) {
    FirebaseFirestore.instance.collection("chatroom").doc(chatroomid).set({
      "chatroomid": chatroomid,
      "lastmessage": lastmessage,
      "participents": participents,
    });
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc("Iym4sUVSJ99TZSg15aRG")
        .get()
        .then((value) {
      log("${jsonEncode(value.data())}");
    });
  }
}
