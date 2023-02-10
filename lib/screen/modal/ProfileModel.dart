/// Uid : "OBLhRVPiJRNbuxgpmiXiPxSmSlh2"
/// Profileimg : "https://firebasestorage.googleapis.com/v0/b/messageme-508dc.appspot.com/o/17940c70-a872-11ed-90fe-45bf01304823?alt=media&token=16db9401-8b2e-49f0-893b-49dd8bfe39d0"
/// Email : "parth@gmail.com"
/// Keywords : ["9","99","999","9999","99999","999999","9999999","99999999","999999999","9999999999"]
/// Username : "Dada No Dost"
/// Aboutme : "I'm a friend of Dada"
/// Mobile : "9999999999"

class ProfileModel {
  ProfileModel({
      String? uid, 
      String? profileimg, 
      String? email, 
      List<String>? keywords, 
      String? username, 
      String? aboutme, 
      String? mobile,}){
    _uid = uid;
    _profileimg = profileimg;
    _email = email;
    _keywords = keywords;
    _username = username;
    _aboutme = aboutme;
    _mobile = mobile;
}

  ProfileModel.fromJson(dynamic json) {
    _uid = json['Uid'];
    _profileimg = json['Profileimg'];
    _email = json['Email'];
    _keywords = json['Keywords'] != null ? json['Keywords'].cast<String>() : [];
    _username = json['Username'];
    _aboutme = json['Aboutme'];
    _mobile = json['Mobile'];
  }
  String? _uid;
  String? _profileimg;
  String? _email;
  List<String>? _keywords;
  String? _username;
  String? _aboutme;
  String? _mobile;
ProfileModel copyWith({  String? uid,
  String? profileimg,
  String? email,
  List<String>? keywords,
  String? username,
  String? aboutme,
  String? mobile,
}) => ProfileModel(  uid: uid ?? _uid,
  profileimg: profileimg ?? _profileimg,
  email: email ?? _email,
  keywords: keywords ?? _keywords,
  username: username ?? _username,
  aboutme: aboutme ?? _aboutme,
  mobile: mobile ?? _mobile,
);
  String? get uid => _uid;
  String? get profileimg => _profileimg;
  String? get email => _email;
  List<String>? get keywords => _keywords;
  String? get username => _username;
  String? get aboutme => _aboutme;
  String? get mobile => _mobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Uid'] = _uid;
    map['Profileimg'] = _profileimg;
    map['Email'] = _email;
    map['Keywords'] = _keywords;
    map['Username'] = _username;
    map['Aboutme'] = _aboutme;
    map['Mobile'] = _mobile;
    return map;
  }

}