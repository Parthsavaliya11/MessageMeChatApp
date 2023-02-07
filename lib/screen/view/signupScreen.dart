import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/utils/components/appbar.dart';
import 'package:messageme/utils/components/btn.dart';
import 'package:messageme/utils/components/txt_field.dart';
import 'package:messageme/utils/constant/const_sizebox.dart';
import 'package:messageme/utils/textthem.dart';

import '../controller/signup_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomSheet: createAcc(),
        appBar: Backbar("Create Account", Colors.black),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h(32.h),
              Text(
                "Email Address",
                style:
                    simpleTextStyle(Colors.black, 16.sp, fw: FontWeight.w600),
              ),
              h(8.h),
              txt_field(
                  hint: "Email Address",
                  textInputType: TextInputType.emailAddress,
                  Helper: "Enter Email Address",
                  txtaction: TextInputAction.next,
                  textEditingController:
                      SignupController.Controller.txt_up_email),
              h(16.h),
              Text(
                "Password",
                style:
                    simpleTextStyle(Colors.black, 16.sp, fw: FontWeight.w600),
              ),
              h(8.h),
              txt_field(
                  hint: "Password",
                  textInputType: TextInputType.visiblePassword,
                  Helper: "Enter 6 Character Password",
                  textEditingController:
                      SignupController.Controller.txt_up_password),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
