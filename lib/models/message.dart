// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';


class MessageModel {
  final String id;
  final String senderUid;
  final String message;
  final DateTime date;
  MessageModel({
    required this.id,
    required this.senderUid,
    required this.message,
    required this.date,
  });

  MessageModel copyWith({
    String? id,
    String? senderUid,
    String? message,
    DateTime? date,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderUid: senderUid ?? this.senderUid,
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'senderUid': senderUid,
      'message': message,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      senderUid: map['senderUid'] as String,
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  static MessageModel fromSnap(DocumentSnapshot snapshot) {
    return MessageModel(
      id: snapshot['id'],
      senderUid: snapshot['senderUid'],
      message: snapshot['message'],
      date: DateTime.fromMillisecondsSinceEpoch(
          snapshot['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, senderUid: $senderUid, message: $message, date: $date)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.senderUid == senderUid &&
      other.message == message &&
      other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      senderUid.hashCode ^
      message.hashCode ^
      date.hashCode;
  }
}
