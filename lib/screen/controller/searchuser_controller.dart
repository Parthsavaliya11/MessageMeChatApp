import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modal/ProfileModel.dart';

class SearchuserController extends GetxController {
  SearchuserController._();

  static final Controller = SearchuserController._();
  TextEditingController txt_usersearch = TextEditingController();
  String? Cusermobile;
  RxList<ProfileModel> founduser = <ProfileModel>[].obs;
  RxString searchkeyword = "".obs;
  ProfileModel targetuser = ProfileModel();

  onchange(String value) {
    searchkeyword = value.obs;
  }
}
