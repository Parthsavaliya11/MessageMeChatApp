import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/chatpage_controller.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';
import 'package:messageme/screen/modal/ChatviewModel.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';
import 'package:uuid/uuid.dart';

import '../modal/ProfileModel.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: TextField(
                onChanged: (value) {
                  SearchuserController.Controller.searchkeyword.value = value;
                },
                keyboardType: TextInputType.phone,
                controller: SearchuserController.Controller.txt_usersearch,
                decoration: InputDecoration(
                  hintText: "Search User",
                  hintStyle: TextStyle(fontSize: 16.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Obx(
              () => StreamBuilder(
                stream: FirestoreHelper.firestore.Searchuser(
                    SearchuserController.Controller.searchkeyword.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      //
                      if (data.length > 0) {
                        SearchuserController.Controller.founduser.value =
                            data.map((e) => ProfileModel.fromJson(e)).toList();
                        //
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: SearchuserController
                                .Controller.founduser.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: InkWell(
                                  onTap: () async {
                                    SearchuserController.Controller.targetuser =
                                        SearchuserController
                                            .Controller.founduser[index];

                                    ChatviewModel chatroommodel = await getroom(
                                        username: SearchuserController
                                            .Controller
                                            .founduser[index]
                                            .username
                                            .toString(),
                                        targetuid: SearchuserController
                                            .Controller.founduser[index].uid!);

                                    if (chatroommodel != null) {
                                      await FirestoreHelper.firestore
                                          .CreateChatroom(
                                        chatroomModel: chatroommodel,
                                        targetuid: SearchuserController
                                            .Controller.founduser[index].uid
                                            .toString(),
                                      );

                                      ChatpageContrller.Controller.Chatroomid =
                                          chatroommodel.chatroomid;

                                      Get.toNamed("/chatpage");
                                    }
                                  },
                                  child: ListTile(
                                    subtitle: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${SearchuserController.Controller.founduser[index].aboutme}",
                                      style: simpleTextStyle(
                                          const Color(0xff9C9797), 14.sp,
                                          fw: FontWeight.w400),
                                    ),
                                    title: Text(
                                      "${SearchuserController.Controller.founduser[index].username}",
                                      style: simpleTextStyle(
                                          Colors.black, 16.sp,
                                          fw: FontWeight.w400),
                                    ),
                                    leading: SizedBox(
                                      height: 58.h,
                                      width: 58.h,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${SearchuserController.Controller.founduser[index].profileimg}"),
                                      ),
                                    ),
                                    trailing: Text(
                                      "29 mar",
                                      style: simpleTextStyle(
                                          const Color(0xff74777F), 12.sp),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Text("Result Not Found");
                      }
                    } else if (snapshot.hasError) {
                      return SelectableText("${snapshot.error}");
                    } else {
                      return Text("No Result Found");
                    }
                  } else {
                    Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<ChatviewModel> getroom(
    {required String targetuid, required String username}) async {
  ChatviewModel chatroomModel;
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection("chatroom")
      .where("members.${FirebaseAuth.instance.currentUser!.uid}",
          isEqualTo: true)
      .where("members.$targetuid", isEqualTo: true)
      .get();
  if (querySnapshot.docs.length > 0) {
    var data = querySnapshot.docs[0].data();
    ChatviewModel exitingRoom = ChatviewModel.fromJson(data);
    chatroomModel = exitingRoom;
  } else {
    ChatviewModel Newchatroommodel = ChatviewModel(
        messages: [
          Messages(
              senderid: FirebaseAuth.instance.currentUser!.uid,
              messageid: Uuid().v1(),
              createAt: DateTime.now(),
              seen: false,
              text:
                  "Hey,Welcome To MessageMe Chatting Platform & Staring Chat With $username")
        ],
        chatroomid: Uuid().v1(),
        lastmessage:
            "Hey,Welcome To MessageMe Chatting Platform & Staring Chat With $username",
        members: {
          targetuid: true,
          FirebaseAuth.instance.currentUser!.uid: true,
        });
    log("baki hatu bahi");
    await FirebaseFirestore.instance
        .collection("chatroom")
        .doc(Newchatroommodel.chatroomid)
        .set(Newchatroommodel.toJson());
    chatroomModel = Newchatroommodel;
  }
  return chatroomModel;
}
