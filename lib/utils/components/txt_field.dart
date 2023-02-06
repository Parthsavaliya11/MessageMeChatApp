import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget txt_field(
    {TextEditingController? textEditingController,
    required String hint,
    TextInputType? textInputType,String? Helper,TextInputAction? txtaction}) {
  return TextField(
    textInputAction: txtaction,
    keyboardType: textInputType,
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: hint,helperText: Helper,
      hintStyle: TextStyle(fontSize: 16.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
