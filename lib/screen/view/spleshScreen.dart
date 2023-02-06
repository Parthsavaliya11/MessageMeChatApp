import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/fireauth_helper.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key? key}) : super(key: key);

  @override
  State<SpleshScreen> createState() => _SpleshScreenState();
}

class _SpleshScreenState extends State<SpleshScreen> {
  @override
  Widget build(BuildContext context) {
    checkUser();
    return SafeArea(
      child: Scaffold(
        backgroundColor: bluecolor,
        body: Center(
          child: SvgPicture.asset(
            "assets/images/white.svg",
            height: 220.h,
            width: 220.h,
          ),
        ),
      ),
    );
  }
}

void checkUser(){
  bool check = FireauthHelper.AuthHelper.isLogin();
  if (check == true) {
    Timer(const Duration(seconds: 4), () => Get.offAllNamed('/login'));
  } else {
    Timer(const Duration(seconds: 4), () => Get.offAllNamed('/signup'));
  }
}
