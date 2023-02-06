import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/login_controller.dart';
import 'package:messageme/screen/view/signupScreen.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/fireauth_helper.dart';

import '../../screen/controller/signup_controller.dart';

Widget loginbtn() {
  return SizedBox(
    height: 60.h,
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () async {
        String msg = await FireauthHelper.AuthHelper.customLogin(
            email: LoginController.Controller.txt_in_email.text,
            password: LoginController.Controller.txt_in_password.text);
        Get.snackbar("MessageMe", msg);
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
    height: 60.h,
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
        style: TextStyle(fontSize: 16, color: Colors.black),
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
          String msg = await FireauthHelper.AuthHelper.CheckCustomUser(
              email: SignupController.Controller.txt_up_email.text,
              password: SignupController.Controller.txt_up_password.text);
          Get.snackbar("MessageMe", msg);
        },
        child: const Text(
          "Create a new account",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    ),
  );
}
