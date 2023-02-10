import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  SignupController._();

  static final Controller = SignupController._();
  TextEditingController txt_up_email = TextEditingController();
  TextEditingController txt_up_password = TextEditingController();

  searchsystem(String value)
  {
    List<String> charsearchlist = [];
    String temp = "";
    for(int i=0; i<value.length ;i++)
    {
      temp = temp + value[i];
      charsearchlist.add(temp);
    }
    return charsearchlist;
  }
}
