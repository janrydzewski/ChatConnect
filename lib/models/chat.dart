// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ChatModel {
  final String id;
  final List<String> users;
  final String lastSender;
  final String lastMessage;
  final DateTime lastMessageDate;
  ChatModel({
    required this.id,
    required this.users,
    required this.lastSender,
    required this.lastMessage,
    required this.lastMessageDate,
  });

  ChatModel copyWith({
    String? id,
    List<String>? users,
    String? lastSender,
    String? lastMessage,
    DateTime? lastMessageDate,
  }) {
    return ChatModel(
      id: id ?? this.id,
      users: users ?? this.users,
      lastSender: lastSender ?? this.lastSender,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'users': users,
      'lastSender': lastSender,
      'lastMessage': lastMessage,
      'lastMessageDate': lastMessageDate.millisecondsSinceEpoch,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] as String,
      users: List<String>.from((map['users'] as List<String>)),
      lastSender: map['lastSender'] as String,
      lastMessage: map['lastMessage'] as String,
      lastMessageDate:
          DateTime.fromMillisecondsSinceEpoch(map['lastMessageDate'] as int),
    );
  }

  static ChatModel fromSnap(DocumentSnapshot snapshot) {
    return ChatModel(
      id: snapshot['id'],
      users: List.from(snapshot['users']),
      lastSender: snapshot['lastSender'],
      lastMessage: snapshot['lastMessage'],
      lastMessageDate: DateTime.fromMillisecondsSinceEpoch(
          snapshot['lastMessageDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(id: $id, users: $users, lastSender: $lastSender, lastMessage: $lastMessage, lastMessageDate: $lastMessageDate)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.users, users) &&
        other.lastSender == lastSender &&
        other.lastMessage == lastMessage &&
        other.lastMessageDate == lastMessageDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        users.hashCode ^
        lastSender.hashCode ^
        lastMessage.hashCode ^
        lastMessageDate.hashCode;
  }

  factory ChatModel.testMessage() {
    return ChatModel(
      id: "1",
      users: ["Jan Rydzewski", "Martyna Pietranik", "Kacper Rydzewski"],
      lastSender: "Martyna Pietranik",
      lastMessage:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      lastMessageDate: DateTime.now(),
    );
  }
}
