import 'package:cloud_firestore/cloud_firestore.dart';

class PositiveBills {
  String title;
  String desc;
  String changeUrl;
  String category;
  String details;
  String imageUrl;
  bool isPassed;
  final DocumentReference reference;

  PositiveBills({
    this.title,
    this.desc,
    this.changeUrl,
    this.category,
    this.details,
    this.isPassed,
    this.imageUrl,
    this.reference,
  });

  PositiveBills.fromJson(
    Map<String, dynamic> json, {
    this.reference,
  }) {
    title = json['title'];
    desc = json['desc'];
    title = json['title'];
    changeUrl = json['changeUrl'];
    category = json['category'];
    details = json['details'];
    imageUrl = json['imageUrl'];
    isPassed = json['isPassed'];
  }

  PositiveBills.fromMap(
    Map<dynamic, dynamic> map, {
    this.reference,
  }) {
    title = map['title'];
    desc = map['desc'];
    changeUrl = map['changeUrl'];
    category = map['category'];
    details = map['details'];
    imageUrl = map['imageUrl'];
    isPassed = map['isPassed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> senatorData = new Map<String, dynamic>();
    senatorData['title'] = this.title;
    senatorData['desc'] = this.desc;
    senatorData['changeUrl'] = this.changeUrl;
    senatorData['category'] = this.category;
    senatorData['details'] = this.details;
    senatorData['imageUrl'] = this.imageUrl;
    senatorData['isPassed'] = this.isPassed;
    return senatorData;
  }

  PositiveBills.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);
}
