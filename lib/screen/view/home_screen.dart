import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/hometochatController.dart';
import 'package:messageme/screen/modal/ChatroomModel.dart';
import 'package:messageme/screen/modal/ProfileModel.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';

import '../../utils/components/profile_tile.dart';
import '../controller/home_controller.dart';

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
                  HomescreenController.Controller.chatroomdata = snapshotData
                      .map((e) => ChatroomModel.fromJson(e.data()))
                      .toList();

                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshotData.length,
                    itemBuilder: (context, index) {
                      log("${index}");
                      ChatroomModel chatroomModel = ChatroomModel.fromJson(
                        snapshotData[index].data(),
                      );
                      HomescreenController.Controller.parcipentskeys =
                          chatroomModel.members!.keys.toList();
                      HomescreenController.Controller.parcipentskeys
                          .remove(FirebaseAuth.instance.currentUser!.uid);

                      return FutureBuilder(
                          future: FirestoreHelper.firestore.profilebyUid(
                              HomescreenController
                                  .Controller.parcipentskeys[0]),
                          builder: (context, data) {
                            return profileTile(
                              profileimg: '${data.data!.profileimg}',
                              lastmsg:
                                  '${HomescreenController.Controller.chatroomdata[index].lastmessage}',
                              username: '${data.data!.username}',
                              onTap: () {
                                HometochatController.Controller.targetuser =
                                    data.data!;
                                HometochatController.Controller.Chatroomid =
                                    HomescreenController.Controller
                                        .chatroomdata[index].chatroomid;

                                Get.toNamed("/hometochat");
                              },
                            );
                          });
                    },
                  );
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
