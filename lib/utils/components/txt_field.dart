import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget txt_field(
    {TextEditingController? textEditingController,
    required String hint,
    TextInputType? textInputType,
    String? Helper,
    TextInputAction? txtaction,
    int? max}) {
  return TextField(
    textInputAction: txtaction,
    keyboardType: textInputType,
    controller: textEditingController,
    maxLength: max,
    decoration: InputDecoration(
      hintText: hint,
      helperText: Helper,

      hintStyle: TextStyle(fontSize: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}

Widget fill_txt_field(
    {TextEditingController? textEditingController,
    required String hint,
    TextInputType? textInputType,
    String? Helper,
    TextInputAction? txtaction}) {
  return TextField(
    textInputAction: txtaction,
    keyboardType: textInputType,
    controller: textEditingController,
    decoration: InputDecoration(
      fillColor: const Color(0xffE0E0E0),
      hintText: hint,
      helperText: Helper,
      hintStyle: TextStyle(fontSize: 16.sp),
      border: InputBorder.none,
      filled: true,
    ),
  );
}

Widget chat_field(
    {TextEditingController? textEditingController,
    required String hint,
    TextInputType? textInputType,
    String? Helper,
    TextInputAction? txtaction,
    int? max}) {
  return TextField(
    textInputAction: txtaction,
    keyboardType: textInputType,
    controller: textEditingController,
    maxLength: max,
    decoration: InputDecoration(
      suffix: IconButton(
        onPressed: () {},
        icon: Icon(Icons.send),
      ),
      hintText: hint,
      helperText: Helper,
      hintStyle: TextStyle(fontSize: 16.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
