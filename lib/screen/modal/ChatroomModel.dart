/// lastmessage : "hfwhglwhg"
/// members : {"m1":"rgeg","m2":"hsththeth"}
/// chatroomid : "124jjk235kjbklh"

class ChatroomModel {
  ChatroomModel({
    String? lastmessage,
    Map<String, dynamic>? members,
    String? chatroomid,
  }) {
    _lastmessage = lastmessage;
    _members = members;
    _chatroomid = chatroomid;
  }

  ChatroomModel.fromJson(dynamic json) {
    _lastmessage = json['lastmessage'];
    _members = json['members'];
    _chatroomid = json['chatroomid'];
  }

  String? _lastmessage;
  Map<String, dynamic>? _members;
  String? _chatroomid;

  ChatroomModel copyWith({
    String? lastmessage,
    Map<String, dynamic>? members,
    String? chatroomid,
  }) =>
      ChatroomModel(
        lastmessage: lastmessage ?? _lastmessage,
        members: members ?? _members,
        chatroomid: chatroomid ?? _chatroomid,
      );

  String? get lastmessage => _lastmessage;

  Map<String, dynamic>? get members => _members;

  String? get chatroomid => _chatroomid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastmessage'] = _lastmessage;
    if (_members != null) {
      map['members'] = _members;
    }
    map['chatroomid'] = _chatroomid;
    return map;
  }
}
