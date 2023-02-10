import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/login_controller.dart';
import 'package:messageme/screen/controller/profileset_controller.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/fireauth_helper.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/storage_helper.dart';

import '../../screen/controller/signup_controller.dart';
import '../get_storage.dart';

Widget loginbtn() {
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () async {
        String msg = await FireauthHelper.AuthHelper.CheckCustomUser(
            email: LoginController.Controller.txt_in_email.text,
            password: LoginController.Controller.txt_in_password.text);

        Get.snackbar("MessageMe", msg);

        if (msg == "User Success To Login") {
          FirebaseFirestore.instance
              .collection("profile")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            var mobile = value['Mobile'];
            GetStorageHelper.Helper.Writedata(value: mobile, key: "usermobile");
          });
          Get.offAllNamed("/home");
        }
      },
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 16),
      ),
    ),
  );
}

Widget signupbtn() {
  return SizedBox(
    height: 60,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xffE5E5E5),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Get.toNamed(
          "/signup",
        );
      },
      child: const Text(
        "Create a new account",
        style: TextStyle(fontSize: 16 , color: Colors.black),
      ),
    ),
  );
}

Widget createAcc() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
    child: SizedBox(
      height: 60.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bluecolor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () async {
          String msg = await FireauthHelper.AuthHelper.customLogin(
              email: SignupController.Controller.txt_up_email.text,
              password: SignupController.Controller.txt_up_password.text);
          Get.snackbar("MessageMe", msg);
          if (msg == "User Success To Create Account") {
            Get.offNamed("/profileset");
          }
        },
        child: const Text(
          "Create a new account",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  );
}

Widget profilebtn({required String imgpath}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
    child: SizedBox(
      height: 60.h,
      width: double.infinity,
      child: Obx(
        () => ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: bluecolor,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: ProfilesetController.Controller.isbtn.value
              ? null
              : () async {
                  log("$imgpath egeoe");
                  if ((ProfilesetController.Controller.txt_name.text != "") &&
                      (ProfilesetController.Controller.txt_no.text != "") &&
                      (ProfilesetController.Controller.txt_about.text != "") &&
                      (imgpath != "")) {
                    ProfilesetController.Controller.isbtn.value = true;
                    String? imglink =
                        await StorageHelper.storage.Uploadimg(imglink: imgpath);
                    FirestoreHelper.firestore.ProfileData(
                        username: ProfilesetController.Controller.txt_name.text,
                        mobile: ProfilesetController.Controller.txt_no.text,
                        aboutme: ProfilesetController.Controller.txt_about.text,
                        profileimg: imglink!);

                    Get.offAllNamed('/home');
                  } else {
                    Get.showSnackbar(const GetSnackBar(
                      title: "MessageMe",
                      message: "Field is empty",
                      margin: EdgeInsets.all(15),
                      borderRadius: 15,
                      barBlur: 10,
                      duration: Duration(seconds: 2),
                      snackStyle: SnackStyle.FLOATING,
                      snackPosition: SnackPosition.BOTTOM,
                    ));
                  }
                },
          child: ProfilesetController.Controller.isbtn.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Text(
                  "Create a new account",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
        ),
      ),
    ),
  );
}
