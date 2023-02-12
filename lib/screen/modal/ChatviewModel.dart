/// lastmessage : "feg"
/// members : {"8j4v7NQ2e7aNpOOHJoEXh9g5mfo2":true,"OBLhRVPiJRNbuxgpmiXiPxSmSlh2":true}
/// messages : [{"senderid":"8j4v7NQ2e7aNpOOHJoEXh9g5mfo2","messageid":"6698fc10-a960-11ed-9670-1fab3eeeaf43","text":"hg","seen":false,"createAt":"2023-02-10 22:01:42.161430"}]
/// chatroomid : "64b288d0-a960-11ed-8764-133e9aa21876"

class ChatviewModel {
  ChatviewModel({
    String? lastmessage,
    Map<String, dynamic>? members,
    List<Messages>? messages,
    String? chatroomid,
  }) {
    _lastmessage = lastmessage;
    _members = members;
    _messages = messages;
    _chatroomid = chatroomid;
  }

  ChatviewModel.fromJson(dynamic json) {
    _lastmessage = json['lastmessage'];
    _members = json['members'];
    if (json['messages'] != null) {
      _messages = [];
      json['messages'].forEach((v) {
        _messages?.add(Messages.fromJson(v));
      });
    }
    _chatroomid = json['chatroomid'];
  }

  String? _lastmessage;
  Map<String, dynamic>? _members;
  List<Messages>? _messages;
  String? _chatroomid;

  ChatviewModel copyWith({
    String? lastmessage,
    Map<String, dynamic>? members,
    List<Messages>? messages,
    String? chatroomid,
  }) =>
      ChatviewModel(
        lastmessage: lastmessage ?? _lastmessage,
        members: members ?? _members,
        messages: messages ?? _messages,
        chatroomid: chatroomid ?? _chatroomid,
      );

  String? get lastmessage => _lastmessage;

  Map<String, dynamic>? get members => _members;

  List<Messages>? get messages => _messages;

  String? get chatroomid => _chatroomid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lastmessage'] = _lastmessage;
    if (_members != null) {
      map['members'] = _members;
    }
    if (_messages != null) {
      map['messages'] = _messages?.map((v) => v.toJson()).toList();
    }
    map['chatroomid'] = _chatroomid;
    return map;
  }
}

/// senderid : "8j4v7NQ2e7aNpOOHJoEXh9g5mfo2"
/// messageid : "6698fc10-a960-11ed-9670-1fab3eeeaf43"
/// text : "hg"
/// seen : false
/// createAt : "2023-02-10 22:01:42.161430"

class Messages {
  Messages({
    String? senderid,
    String? messageid,
    String? text,
    bool? seen,
    DateTime? createAt,
  }) {
    _senderid = senderid;
    _messageid = messageid;
    _text = text;
    _seen = seen;
    _createAt = createAt;
  }

  Messages.fromJson(dynamic json) {
    _senderid = json['senderid'];
    _messageid = json['messageid'];
    _text = json['text'];
    _seen = json['seen'];
    _createAt = DateTime.parse(json['createAt'].toDate().toString());
  }

  String? _senderid;
  String? _messageid;
  String? _text;
  bool? _seen;
  DateTime? _createAt;

  Messages copyWith({
    String? senderid,
    String? messageid,
    String? text,
    bool? seen,
    DateTime? createAt,
  }) =>
      Messages(
        senderid: senderid ?? _senderid,
        messageid: messageid ?? _messageid,
        text: text ?? _text,
        seen: seen ?? _seen,
        createAt: createAt ?? _createAt,
      );

  String? get senderid => _senderid;

  String? get messageid => _messageid;

  String? get text => _text;

  bool? get seen => _seen;

  DateTime? get createAt => _createAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['senderid'] = _senderid;
    map['messageid'] = _messageid;
    map['text'] = _text;
    map['seen'] = _seen;
    map['createAt'] = _createAt;
    return map;
  }
}
