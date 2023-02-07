import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageHelper {
  StorageHelper._();

  static final storage = StorageHelper._();
  UploadTask? uploadTask;
  String? downloadurl;
  StreamSubscription? streamSubscription;

  // profile img upload on storgae
  Future<String?> Uploadimg({required String imglink}) async {
    // file upload
    uploadTask =
        FirebaseStorage.instance.ref().child(const Uuid().v1()).putFile(
              File(imglink),
            );

    // live loding value
    streamSubscription = uploadTask!.snapshotEvents.listen((event) {
      event.bytesTransferred / event.totalBytes * 100;
    });

    // get link;
    TaskSnapshot taskSnapshot = await uploadTask!;
    downloadurl = await taskSnapshot.ref.getDownloadURL();
    streamSubscription!.cancel();
    return downloadurl;
  }
}
