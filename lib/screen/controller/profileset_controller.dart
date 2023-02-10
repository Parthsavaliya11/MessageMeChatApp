import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:messageme/utils/constant/const_color.dart';

class ProfilesetController extends GetxController {
  ProfilesetController._();

  static final Controller = ProfilesetController._();
  TextEditingController txt_name = TextEditingController();
  TextEditingController txt_no = TextEditingController();
  TextEditingController txt_about = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  RxString img_path = "".obs;
  RxBool isbtn = false.obs;
  final profilekey = GlobalKey<FormState>();


  // profile img pick, crop and return compress file
  Future<String> imagepick() async {
    XFile? xFile = await _picker.pickImage(source: ImageSource.gallery);

    // after image cropped from selected image
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: xFile!.path,
      cropStyle: CropStyle.circle,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Image Cropper',
            toolbarColor: bluecolor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        IOSUiSettings(
          title: 'Image Cropper',
        ),
      ],
    );
    File file = File(croppedFile!.path);
    var compressfile = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, '${file.path}compress.jpg',
        quality: 40);
    log("$compressfile -----------------------");
    return compressfile!.path;
  }
}
