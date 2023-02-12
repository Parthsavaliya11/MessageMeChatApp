import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/chatpage_controller.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';
import 'package:messageme/screen/modal/ChatModel.dart';
import 'package:messageme/screen/modal/ChatviewModel.dart';
import 'package:messageme/utils/constant/const_color.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';
import 'package:uuid/uuid.dart';

class Chatpage extends StatefulWidget {
  const Chatpage({Key? key}) : super(key: key);

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
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
        body: Column(
          children: [
            StreamBuilder(
              stream: FirestoreHelper.firestore.readChat(
                chatroomid: ChatpageContrller.Controller.Chatroomid.toString(),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    ChatpageContrller.Controller.uiData.clear();
                    ChatpageContrller.Controller.uiData.add(
                      ChatviewModel.fromJson(
                        snapshot.data!.data(),
                      ),
                    );



                    return Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          reverse: true,
                          controller:
                              ChatpageContrller.Controller.scrollController,
                          itemCount: ChatpageContrller
                                  .Controller.uiData[0].messages!.length +
                              1,
                          itemBuilder: (context, index) {
                            if (index ==
                                ChatpageContrller
                                    .Controller.uiData[0].messages!.length) {
                              return Container(
                                height: 60,
                              );
                            }
                            return ChatpageContrller.Controller.uiData[0]
                                        .messages![index].senderid ==
                                    FirebaseAuth.instance.currentUser!.uid
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChatBubble(
                                      alignment: Alignment.topRight,
                                      margin: EdgeInsets.only(left: 50),
                                      backGroundColor: bluecolor,
                                      clipper: ChatBubbleClipper5(
                                          type: BubbleType.sendBubble),
                                      child: Text(
                                        "${ChatpageContrller.Controller.uiData[0].messages![index].text}",
                                        style: simpleTextStyle(
                                            Colors.white, 16.sp),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChatBubble(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(right: 50),
                                      backGroundColor: Colors.grey,
                                      clipper: ChatBubbleClipper5(
                                          type: BubbleType.receiverBubble),
                                      child: Text(
                                        "${ChatpageContrller.Controller.uiData[0].messages![index].text}",
                                        style: simpleTextStyle(
                                            Colors.white, 16.sp),
                                      ),
                                    ),
                                  );
                          }),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  child: Card(
                    margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    color: Color(0xffeff1ff),
                    child: TextField(
                      controller: ChatpageContrller.Controller.txt_chat,
                      maxLines: 5,
                      clipBehavior: Clip.antiAlias,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              ChatModel chatModel = ChatModel(
                                  messageid: Uuid().v1(),
                                  createAt: DateTime.now(),
                                  seen: false,
                                  senderid:
                                      FirebaseAuth.instance.currentUser!.uid,
                                  text: ChatpageContrller
                                      .Controller.txt_chat.text
                                      .trim());
                              FirestoreHelper.firestore.SendMessage(
                                chatroomid:
                                    ChatpageContrller.Controller.Chatroomid!,
                                chatModel: chatModel,
                                msg: ChatpageContrller.Controller.txt_chat.text
                                    .trim(),
                              );
                              ChatpageContrller.Controller.scrollToBottom();
                            },
                            icon: Icon(Icons.send),
                          ),
                          contentPadding: EdgeInsets.all(20),
                          border: InputBorder.none,
                          hintStyle: simpleTextStyle(Colors.grey.shade600, 16),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.attach_file_sharp),
                          ),
                          hintText: "Type a message..."),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// TextField(
// controller: ChatpageContrller.Controller.txt_chat,
// decoration: InputDecoration(
// hintText: "Type Message",
// suffixIcon: IconButton(
// onPressed: () {
// ChatModel chatModel = ChatModel(
// messageid: Uuid().v1(),
// createAt: DateTime.now(),
// seen: false,
// senderid: FirebaseAuth.instance.currentUser!.uid,
// text: ChatpageContrller.Controller.txt_chat.text
//     .trim());
// FirestoreHelper.firestore.SendMessage(
// chatroomid: ChatpageContrller.Controller.Chatroomid!,
// chatModel: chatModel,
// msg: ChatpageContrller.Controller.txt_chat.text.trim(),
// );
// ChatpageContrller.Controller.scrollToBottom();
// },
// icon: Icon(Icons.send),
// ),
// prefixIcon: IconButton(
// onPressed: () async {
// await FirebaseFirestore.instance
//     .collection("chatroom")
//     .where("${ChatpageContrller.Controller.Chatroomid}")
//     .orderBy("messages.createAt", descending: true)
//     .get()
//     .then((value) {
// log("${value.docs}");
// });
// },
// icon: const Icon(Icons.emoji_emotions),
// ),
// border: InputBorder.none,
// fillColor: Colors.white),
// ),