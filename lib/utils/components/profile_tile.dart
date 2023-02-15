import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../textthem.dart';

Widget profileTile(
    {required String lastmsg,
    required String username,
    required String profileimg,required VoidCallback onTap}) {
  return ListTile(
    onTap: onTap,
    subtitle: Text(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      lastmsg=="" ? "Say Hi Your Friends" : lastmsg,
      style:
          simpleTextStyle(const Color(0xff9C9797), 14.sp, fw: FontWeight.w400),
    ),
    title: Text(
      username,
      style: simpleTextStyle(Colors.black, 16.sp, fw: FontWeight.w400),
    ),
    leading: SizedBox(
      height: 58.h,
      width: 58.h,
      child: CircleAvatar(
        backgroundImage: NetworkImage(profileimg),
      ),
    ),
    trailing: Text(
      "29 mar",
      style: simpleTextStyle(const Color(0xff74777F), 12.sp),
    ),
  );
}
