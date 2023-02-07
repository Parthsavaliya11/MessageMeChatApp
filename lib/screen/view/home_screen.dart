import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/utils/textthem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 58.h,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "${FirebaseAuth.instance.currentUser!.email}",
            style: simpleTextStyle(Colors.black, 18.sp, fw: FontWeight.w600),
          ),
          leading: IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Get.offAllNamed('/login');
            },
            icon: const Icon(Icons.logout,color: Colors.black),
          ),
        ),
      ),
    );
  }
}
