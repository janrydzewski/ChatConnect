// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String id;
  final String authorId;
  final String message;
  final DateTime date;
  PostModel({
    required this.id,
    required this.authorId,
    required this.message,
    required this.date,
  });
  

  PostModel copyWith({
    String? id,
    String? authorId,
    String? message,
    DateTime? date,
  }) {
    return PostModel(
      id: id ?? this.id,
      authorId: authorId ?? this.authorId,
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'authorId': authorId,
      'message': message,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as String,
      authorId: map['authorId'] as String,
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  static PostModel fromSnap(DocumentSnapshot snapshot) {
    return PostModel(
      id: snapshot['id'],
      authorId: snapshot['authorId'],
      message: snapshot['message'],
      date: DateTime.fromMillisecondsSinceEpoch(
          snapshot['lastMessageDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory PostModel.empty() => PostModel(id: "", authorId: "", message: "", date: DateTime.now());

  @override
  String toString() {
    return 'PostModel(id: $id, authorId: $authorId, message: $message, date: $date)';
  }

  @override
  bool operator ==(covariant PostModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.authorId == authorId &&
      other.message == message &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      authorId.hashCode ^
      message.hashCode ^
      date.hashCode;
  }
}
