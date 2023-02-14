import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/modal/ChatroomModel.dart';
import 'package:messageme/screen/modal/ProfileModel.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ProfileModel> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Get.toNamed("/searchuser");
          },
          child: Icon(Icons.chat_outlined),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrooled) {
            return [
              SliverAppBar(
                  actions: [
                    IconButton(
                      iconSize: 25,
                      icon: const Icon(Icons.search),
                      onPressed: () async {},
                    ),
                  ],
                  iconTheme: const IconThemeData(color: Colors.black),
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  floating: true,
                  title: Text(
                    "MessageMe",
                    style: simpleTextStyle(Colors.black, 25.sp,
                        fw: FontWeight.w600),
                  )),
            ];
          },
          floatHeaderSlivers: true,
          body: StreamBuilder(
              stream: FirestoreHelper.firestore.ReadProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.hasData) {
                  var snapshotData = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: snapshotData.length,
                      itemBuilder: (context, index) {




                      });
                }
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
