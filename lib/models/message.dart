// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class MessageModel {
  final String id;
  final String sender;
  final String receiver;
  final String message;
  final DateTime date;
  MessageModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.message,
    required this.date,
  });

  MessageModel copyWith({
    String? id,
    String? sender,
    String? receiver,
    String? message,
    DateTime? date,
  }) {
    return MessageModel(
      id: id ?? this.id,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      message: message ?? this.message,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'message': message,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] as String,
      sender: map['sender'] as String,
      receiver: map['receiver'] as String,
      message: map['message'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(id: $id, sender: $sender, receiver: $receiver, message: $message, date: $date)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.sender == sender &&
        other.receiver == receiver &&
        other.message == message &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        sender.hashCode ^
        receiver.hashCode ^
        message.hashCode ^
        date.hashCode;
  }

  factory MessageModel.testMessage() {
    return MessageModel(
      id: "1",
      sender: "Jan Rydzewski",
      receiver: "Martyna Pietranik",
      message:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      date: DateTime.now(),
    );
  }
}
