import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
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
  RxList<ChatviewModel> uiData = <ChatviewModel>[].obs;

  void scrollToBottom() {
    final bottomOffset = scrollController.position.maxScrollExtent;

    // scrollController.animateTo(
    //    scrollController.position.maxScrollExtent,
    //   duration: Duration(milliseconds: 100),
    //   curve: Curves.easeInOut,
    // );
  }
}
