import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/controller/hometochatController.dart';
import 'package:uuid/uuid.dart';

import '../../utils/constant/const_color.dart';
import '../../utils/firestore_helper.dart';
import '../../utils/textthem.dart';
import '../modal/ChatModel.dart';

class HometoChatpage extends StatefulWidget {
  const HometoChatpage({Key? key}) : super(key: key);

  @override
  State<HometoChatpage> createState() => _HometoChatpageState();
}

class _HometoChatpageState extends State<HometoChatpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          primary: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(right: 8.0.w),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "${HometochatController.Controller.targetuser.profileimg}"),
                ),
              ),
            ),
            PopupMenuButton(itemBuilder: (contyxgt) {
              return [
                PopupMenuItem(
                  onTap: () {
                    FirestoreHelper.firestore.blockUser(
                        uid: HometochatController.Controller.targetuser.uid!,
                        chatroomid:
                            HometochatController.Controller.Chatroomid!);
                  },
                  child: Text("Block User"),
                ),
              ];
            }),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "${HometochatController.Controller.targetuser.username}",
            style: simpleTextStyle(Colors.black, 24.h, fw: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: FirestoreHelper.firestore.readChat(
                chatroomid:
                    HometochatController.Controller.Chatroomid.toString(),
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    HometochatController.Controller.uiData.clear();
                    var val = snapshot.data!.docs;

                    HometochatController.Controller.uiData.value =
                        val.map((e) => ChatModel.fromMap(e)).toList();

                    {}
                    return Expanded(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        reverse: true,
                        controller:
                            HometochatController.Controller.scrollController,
                        itemCount:
                            HometochatController.Controller.uiData.length,
                        itemBuilder: (context, index) {
                          if (HometochatController
                                  .Controller.uiData[index].senderid !=
                              FirebaseAuth.instance.currentUser!.uid) {
                            if (HometochatController
                                    .Controller.uiData[index].seen ==
                                false) {
                              FirestoreHelper.firestore.seenUpdate(
                                  chatroomid:
                                      "${HometochatController.Controller.Chatroomid}",
                                  docid:
                                      "${HometochatController.Controller.uiData[index].messageid}");
                            }
                          }
                          return HometochatController.Controller.uiData.isEmpty
                              ? const Center(
                                  child: Text(
                                    "Say,Hi To Your Friends",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )
                              : HometochatController
                                          .Controller.uiData[index].senderid ==
                                      FirebaseAuth.instance.currentUser!.uid
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        HometochatController.Controller
                                                    .uiData[index].seen ==
                                                false
                                            ? Icon(
                                                Icons.check,
                                                color: Colors.grey,
                                                size: 18.sp,
                                              )
                                            : Icon(
                                                Icons.done_all,
                                                color: bluecolor,
                                                size: 18.sp,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ChatBubble(
                                            alignment: Alignment.topRight,
                                            backGroundColor: bluecolor,
                                            clipper: ChatBubbleClipper5(
                                                type: BubbleType.sendBubble),
                                            child: Text(
                                              "${HometochatController.Controller.uiData[index].text}",
                                              style: simpleTextStyle(
                                                  Colors.white, 16.sp),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ChatBubble(
                                        alignment: Alignment.topLeft,
                                        backGroundColor: Colors.grey,
                                        clipper: ChatBubbleClipper5(
                                            type: BubbleType.receiverBubble),
                                        child: Text(
                                          "${HometochatController.Controller.uiData[index].text}",
                                          style: simpleTextStyle(
                                              Colors.white, 16.sp),
                                        ),
                                      ),
                                    );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Error Occur"),
                    );
                  }
                }

                return const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                child: SizedBox(
                  height: 70,
                  width: double.infinity,
                  child: Card(
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    color: const Color(0xffeff1ff),
                    child: TextField(
                      controller: HometochatController.Controller.txt_chat,
                      maxLines: 5,
                      clipBehavior: Clip.antiAlias,
                      minLines: 1,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              ChatModel chatModel = ChatModel(
                                messageid: const Uuid().v1(),
                                createAt: DateTime.now(),
                                seen: false,
                                senderid:
                                    FirebaseAuth.instance.currentUser!.uid,
                                text: HometochatController
                                    .Controller.txt_chat.text
                                    .trim(),
                              );

                              FirestoreHelper.firestore.SendMessage(
                                chatroomid:
                                    HometochatController.Controller.Chatroomid!,
                                chatModel: chatModel,
                                msg: HometochatController
                                    .Controller.txt_chat.text
                                    .trim(),
                              );
                              HometochatController.Controller.scrollToBottom();
                            },
                            icon: const Icon(Icons.send),
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          border: InputBorder.none,
                          hintStyle: simpleTextStyle(Colors.grey.shade600, 16),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file_sharp),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(HometochatController.Controller.uiData.isNotEmpty) {
      FirestoreHelper.firestore.lastmsg(
        chatroomid: HometochatController.Controller.Chatroomid!,
        lastMessage: HometochatController.Controller.uiData.first.text!);
    }
  }
}
