/// title : ""
/// description : ""
/// dueDate : ""

class Task {
  Task({
      this.title, 
      this.uid,
      this.id,
      this.description,
      this.dueDate,});

  Task.fromJson(dynamic json) {
    title = json['title'];
    uid = json['uid'];
    id = json['id'];
    description = json['description'];
    dueDate = json['dueDate'];
  }
  String? title;
  String? uid;
  String? id;
  String? description;
  String? dueDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['dueDate'] = dueDate;
    map['uid'] = uid;
    map['id'] = id;
    return map;
  }

}