import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String photoUrl;

  const UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.photoUrl,
  });

  UserModel copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? photoUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      email: map['email'] as String,
      photoUrl: map['photoUrl'] as String,
    );
  }

  static UserModel fromSnap(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot['id'],
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  factory UserModel.empty() => 
      const UserModel(id: "", firstName: "", lastName: "", email: "", photoUrl: "");

  @override
  String toString() {
    return 'UserModel(id: $id, firstName: $firstName, lastName: $lastName, email: $email, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        photoUrl.hashCode;
  }
}
