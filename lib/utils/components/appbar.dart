import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../textthem.dart';

AppBar Backbar(String title,Color txtcolor) {
  return AppBar(
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18.sp)),
    centerTitle: true,
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: Text(
      title,
      style: simpleTextStyle(txtcolor, 16.sp, fw: FontWeight.w500),
    ),
  );
}
