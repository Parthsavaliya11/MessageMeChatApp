import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:messageme/screen/modal/ChatroomModel.dart';
import 'package:messageme/screen/modal/ChatviewModel.dart';

import '../modal/ChatModel.dart';

class ChatpageContrller extends GetxController {
  ChatpageContrller._();

  static final Controller = ChatpageContrller._();

  ChatModel chatModel = ChatModel();
  ScrollController scrollController = ScrollController();
  TextEditingController txt_chat = TextEditingController();
  String? Chatroomid;
  ChatviewModel chatList = ChatviewModel();
  RxList<ChatModel> uiData = <ChatModel>[].obs;

  void scrollToBottom() {
    //   final bottomOffset = scrollController.position.maxScrollExtent;
    //
    Timer(Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
  }

  void chatseen(int index) {

  }
}
