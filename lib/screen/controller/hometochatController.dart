import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/ChatModel.dart';
import '../modal/ChatviewModel.dart';
import '../modal/ProfileModel.dart';

class HometochatController extends GetxController {
  HometochatController._();

  // ignore: non_constant_identifier_names
  static final Controller = HometochatController._();
  ScrollController scrollController = ScrollController();
  TextEditingController txt_chat = TextEditingController();
  String? Chatroomid;
  ChatviewModel chatList = ChatviewModel();
  RxList<ChatModel> uiData = <ChatModel>[].obs;
  ProfileModel targetuser = ProfileModel();
  void scrollToBottom() {
    //   final bottomOffset = scrollController.position.maxScrollExtent;
    //
    Timer(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    });
  }
}
