import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:messageme/utils/components/txt_field.dart';
import 'package:messageme/utils/constant/const_sizebox.dart';

import '../../utils/components/btn.dart';
import '../controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/blue.svg",
                    height: 120.sp,
                    width: 120.sp,
                  ),
                  h(22.h),
                  Text(
                    "Welcome TO MessageMe",
                    style: GoogleFonts.poppins(
                        fontSize: 24.sp, fontWeight: FontWeight.w500),
                  ),
                  h(64.h),
                  txt_field(
                      hint: "Enter Email Address",
                      textInputType: TextInputType.emailAddress,
                      txtaction: TextInputAction.next,
                      textEditingController:
                          LoginController.Controller.txt_in_email),
                  h(16.h),
                  txt_field(
                      hint: "Password",
                      textInputType: TextInputType.visiblePassword,
                      textEditingController:
                          LoginController.Controller.txt_in_password),
                  h(16.h),
                  loginbtn(),
                  h(16.h),
                  signupbtn(),
                  h(16.h),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.poppins(
                          fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.closeCurrentSnackbar();
  }
}
