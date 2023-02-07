import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreHelper {
  FirestoreHelper._();

  static final firestore = FirestoreHelper._();

  // For Create profile database
  void ProfileData(
      {required String username,
      required String mobile,
      required String profileimg}) {
    FirebaseFirestore.instance
        .collection("profile")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("allprofile")
        .add(
            {"Username": username, "Mobile": mobile, "Profileimg": profileimg});

    // Read ProfileData Method
    Stream<QuerySnapshot<Map<String, dynamic>>> ReadProfile() {
      return FirebaseFirestore.instance
          .collectionGroup("allprofile")
          .snapshots();
    }
  }
}
