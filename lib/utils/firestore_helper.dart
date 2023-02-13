import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:messageme/screen/modal/ChatModel.dart';

import '../screen/controller/signup_controller.dart';
import '../screen/modal/ChatroomModel.dart';

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
    return FirebaseFirestore.instance
        .collection("chatroom")
        .where("members.${FirebaseAuth.instance.currentUser!.uid}",
            isEqualTo: true).where("field")
        .snapshots();
  }

  // search user for chatting

  Stream<QuerySnapshot<Map<String, dynamic>>> Searchuser(
      String searchKeywords) {
    return FirebaseFirestore.instance
        .collection(
          "profile",
        )
        .where("Keywords", arrayContains: searchKeywords)
        .where("Email", isNotEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
  }

  // CREATING A NEW CHATROOM FOR USER NAD USER

  Future<String> CreateChatroom(
      {required ChatroomModel chatroomModel, required String targetuid}) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("chatroom")
        .where("members.${FirebaseAuth.instance.currentUser!.uid}",
            isEqualTo: true)
        .where("members.$targetuid", isEqualTo: true)
        .get();
    if (querySnapshot.docs.length > 0) {
      return "already create";
    } else {
      log("baki hatu bahi");
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatroomModel.chatroomid)
          .set(chatroomModel.toJson());
      return "not create";
    }
  }

  // CREATE CHATS BETWEEN TWO USERS
  void SendMessage(
      {required String chatroomid,
      required ChatModel chatModel,
      required String msg}) {
    if (msg != "") {
      FirebaseFirestore.instance
          .collection("chatroom")
          .doc(chatroomid)
          .collection("msg")
          .doc(chatModel.messageid.toString())
          .set(chatModel.toMap());
    }
  }

  ///// READ USER TO USER CHAT

  Stream<QuerySnapshot<Map<String, dynamic>>> readChat(
      {required String chatroomid}) {
    return FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomid)
        .collection("msg")
        .orderBy("createAt", descending: true)
        .snapshots();
  }

  ////// MESSAGE SEEN OR NOT
  void seenUpdate({required String chatroomid, required String docid}) {
    FirebaseFirestore.instance
        .collection("chatroom")
        .doc(chatroomid)
        .collection("msg")
        .doc(docid)
        .update({"seen": true});
  }
}
