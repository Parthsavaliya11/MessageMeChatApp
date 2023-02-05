import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    ScreenUtilInit(
      designSize:  const Size(393, 852),
      builder: (BuildContext context, Widget? child) {
        return  const GetMaterialApp(
          debugShowCheckedModeBanner: false,
          

        );
      },

    ),
  );
}
