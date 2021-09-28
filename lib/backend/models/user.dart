/// name : ""
/// email : ""
/// phone : ""
/// uid : ""

class User {
  User({
      this.name, 
      this.email, 
      this.phone, 
      this.uid,});

  User.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uid = json['uid'];
  }
  String? name;
  String? email;
  String? phone;
  String? uid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['uid'] = uid;
    return map;
  }

}