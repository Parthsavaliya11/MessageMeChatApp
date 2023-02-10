import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';

import '../../main.dart';
import '../../utils/get_storage.dart';
import '../modal/ProfileModel.dart';
import 'search_userpage.dart';

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
                      onPressed: () {
                        FirestoreHelper.firestore.CreateChatroom(
                            chatroomid: "chatroomid",
                            lastmessage: "lastmessage",
                            participents: {});
                      },
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
                  return const Text("No Data Available In Server");
                } else if (snapshot.hasData) {
                  var z = snapshot.data!.docs;

                  list = z.map((e) => ProfileModel.fromJson(e)).toList();
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: list.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: ListTile(
                            subtitle: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "${list[index].aboutme}",
                              style: simpleTextStyle(
                                  const Color(0xff9C9797), 14.sp,
                                  fw: FontWeight.w400),
                            ),
                            title: Text(
                              "${list[index].username}",
                              style: simpleTextStyle(Colors.black, 16.sp,
                                  fw: FontWeight.w400),
                            ),
                            leading: SizedBox(
                              height: 58.h,
                              width: 58.h,
                              child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage("${list[index].profileimg}"),
                              ),
                            ),
                            trailing: Text(
                              "29 mar",
                              style: simpleTextStyle(
                                  const Color(0xff74777F), 12.sp),
                            ),
                          ),
                        );
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
