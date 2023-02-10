import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/profileset_controller.dart';
import 'package:messageme/utils/components/appbar.dart';
import 'package:messageme/utils/components/btn.dart';
import 'package:messageme/utils/components/txt_field.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/constant/const_sizebox.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({Key? key}) : super(key: key);

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  bool isbtn = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: Backbar("Fill Profile", Colors.black),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 31.w),
            child: Center(
              child: Column(
                children: [
                  h(100.h),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        height: 155.h,
                        width: 155.h,
                        child: Obx(
                          () => CircleAvatar(
                            backgroundColor: Colors.grey.shade400,
                            backgroundImage: ProfilesetController
                                        .Controller.img_path.value ==
                                    ""
                                ? null
                                : FileImage(
                                    File(ProfilesetController
                                        .Controller.img_path.value),
                                  ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5.r,
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor: bluecolor,
                          child: IconButton(
                            onPressed: () async {
                              ProfilesetController.Controller.img_path.value =
                                  await ProfilesetController.Controller
                                      .imagepick();
                              log(ProfilesetController
                                  .Controller.img_path.value);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  h(50.h),
                  txt_field(
                      hint: "Your Name",
                      txtaction: TextInputAction.next,
                      textEditingController:
                          ProfilesetController.Controller.txt_name,
                      textInputType: TextInputType.name),
                  h(26.h),
                  txt_field(
                      max: 20,
                      txtaction: TextInputAction.next,
                      hint: "AboutMe",
                      textEditingController:
                          ProfilesetController.Controller.txt_about,
                      textInputType: TextInputType.multiline),
                  h(26.h),
                  txt_field(
                    max: 10,
                    hint: "Mobile Number",
                    textInputType: TextInputType.phone,
                    textEditingController:
                        ProfilesetController.Controller.txt_no,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Obx(
          () => profilebtn(
              imgpath: ProfilesetController.Controller.img_path.value),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ProfilesetController.Controller.isbtn = false.obs;
  }
}
