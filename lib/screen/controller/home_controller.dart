import 'package:get/get.dart';

import '../modal/ChatroomModel.dart';

class HomescreenController extends GetxController {
  HomescreenController._();

  static final Controller = HomescreenController._();

  List<ChatroomModel> chatroomdata = [];
  List parcipentskeys = [];
}
