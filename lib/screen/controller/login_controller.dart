import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController._();

  static final Controller = LoginController._();
  TextEditingController txt_in_email = TextEditingController();
  TextEditingController txt_in_password = TextEditingController();
}
