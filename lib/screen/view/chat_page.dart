import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';
import 'package:messageme/utils/components/txt_field.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/textthem.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: true,
          automaticallyImplyLeading: true,
          toolbarHeight: 80,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 8.0.w),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "${SearchuserController.Controller.targetuser.profileimg}"),
              ),
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "${SearchuserController.Controller.targetuser.username}",
            style: simpleTextStyle(Colors.black, 24.h, fw: FontWeight.w600),
          ),
        ),
        bottomSheet: Container(
          alignment: Alignment.center,
          height: 100.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Type Message",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.send),
                ),
                prefixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions),
                ),
                border: InputBorder.none,
                fillColor: Colors.white),
          ),
        ),
        body: Column(
          children: [],
        ),
      ),
    );
  }
}
