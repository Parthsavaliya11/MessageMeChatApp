import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  SignupController._();

  static final Controller = SignupController._();
  TextEditingController txt_up_email = TextEditingController();
  TextEditingController txt_up_password = TextEditingController();
}
