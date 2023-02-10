import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:messageme/screen/controller/searchuser_controller.dart';
import 'package:messageme/utils/firestore_helper.dart';
import 'package:messageme/utils/textthem.dart';

import '../modal/ProfileModel.dart';

class SearchUser extends StatefulWidget {
  const SearchUser({Key? key}) : super(key: key);

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.sp),
              child: TextField(
                onChanged: (value) {
                  SearchuserController.Controller.searchkeyword.value = value;
                },
                keyboardType: TextInputType.phone,
                controller: SearchuserController.Controller.txt_usersearch,
                decoration: InputDecoration(
                  hintText: "Search User",
                  hintStyle: TextStyle(fontSize: 16.sp),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Obx(
              () => StreamBuilder(
                stream: FirestoreHelper.firestore.Searchuser(
                    SearchuserController.Controller.searchkeyword.value),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    if (snapshot.hasData) {
                      var data = snapshot.data!.docs;
                      //
                      if (data.length > 0) {
                        SearchuserController.Controller.founduser.value =
                            data.map((e) => ProfileModel.fromJson(e)).toList();
                        //
                        return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: SearchuserController
                                .Controller.founduser.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                child: InkWell(
                                  onTap: () {
                                    Get.toNamed("/chatpage");
                                    SearchuserController.Controller.targetuser =
                                        SearchuserController
                                            .Controller.founduser[index];
                                  },
                                  child: ListTile(
                                    subtitle: Text(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      "${SearchuserController.Controller.founduser[index].aboutme}",
                                      style: simpleTextStyle(
                                          const Color(0xff9C9797), 14.sp,
                                          fw: FontWeight.w400),
                                    ),
                                    title: Text(
                                      "${SearchuserController.Controller.founduser[index].username}",
                                      style: simpleTextStyle(
                                          Colors.black, 16.sp,
                                          fw: FontWeight.w400),
                                    ),
                                    leading: SizedBox(
                                      height: 58.h,
                                      width: 58.h,
                                      child: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            "${SearchuserController.Controller.founduser[index].profileimg}"),
                                      ),
                                    ),
                                    trailing: Text(
                                      "29 mar",
                                      style: simpleTextStyle(
                                          const Color(0xff74777F), 12.sp),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Text("Result Not Found");
                      }
                    } else if (snapshot.hasError) {
                      return SelectableText("${snapshot.error}");
                    } else {
                      return Text("No Result Found");
                    }
                  } else {
                    Center(child: CircularProgressIndicator());
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
