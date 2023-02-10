import 'package:get_storage/get_storage.dart';

class GetStorageHelper {
  GetStorageHelper._();

  static final Helper = GetStorageHelper._();

  GetStorage getStorage = GetStorage();

  // void Werite Data

  void Writedata({required var value, required String key}) {
    getStorage.write(key, value);
  }

  Readdata({required String key}) async {
    dynamic data = await getStorage.read(key);
    return data;
  }

  // For Delete Storage
  void DeleteStorage({required String key})
  {
    getStorage.remove(key);
  }

//////////// ALL KEYS ////////////

/*
    :KEYS:                             WORK
   usermobile ================ to get currentusermobile
*/
}
