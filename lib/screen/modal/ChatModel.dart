class ChatModel {

  String? senderid;
  String? messageid;
  String? text;
  bool? seen;
  DateTime? createAt;

  ChatModel(
      {this.senderid, this.messageid, this.text, this.seen, this.createAt});

  ChatModel.fromMap(dynamic map) {
    senderid = map["senderid"];
    messageid = map["messageid"];
    text = map["text"];
    seen = map["seen"];
    createAt = map["createAt"].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      "senderid": senderid,
      "messageid": messageid,
      "text": text,
      "seen": seen,
      "createAt": createAt,
    };
  }
}
