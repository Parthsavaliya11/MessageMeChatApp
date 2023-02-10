import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:messageme/firebase_options.dart';
import 'package:messageme/utils/routes.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ScreenUtilInit(
      designSize: const Size(393, 852),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(

             primarySwatch: generateMaterialColor(
              color: const Color(0xff3361E1),
            ),
          ),
          debugShowCheckedModeBanner: false,
          getPages: routeList,
        );
      },
    ),
  );
}
