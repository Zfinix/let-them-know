import 'package:cloud_firestore/cloud_firestore.dart';

class NegativeBills {
  String title;
  String desc;
  String changeUrl;
  String category;
  String details;
  String emailMessage;
  bool isPassed;
  String imageUrl;
  final DocumentReference reference;

  NegativeBills({
    this.title,
    this.desc,
    this.changeUrl,
    this.category,
    this.details,
    this.isPassed,
    this.imageUrl,
    this.emailMessage,
    this.reference,
  });

  NegativeBills.fromJson(
    Map<String, dynamic> json, {
    this.reference,
  }) {
    title = json['title'];
    desc = json['desc'];
    changeUrl = json['changeUrl'];
    category = json['category'];
    details = json['details'];
    imageUrl = json['imageUrl'];
    emailMessage = json['emailMessage'];
    isPassed = json['isPassed'];
  }

  NegativeBills.fromMap(
    Map<dynamic, dynamic> map, {
    this.reference,
  }) {
    title = map['title'];
    desc = map['desc'];
    changeUrl = map['changeUrl'];
    category = map['category'];
    details = map['details'];
    emailMessage = map['emailMessage'];
    imageUrl = map['imageUrl'];
    isPassed = map['isPassed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['title'] = this.title;
    json['desc'] = this.desc;
    json['changeUrl'] = this.changeUrl;
    json['category'] = this.category;
    json['details'] = this.details;
    json['emailMessage'] = this.emailMessage;
    json['imageUrl'] = this.imageUrl;
    json['isPassed'] = this.isPassed;
    return json;
  }

  NegativeBills.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
