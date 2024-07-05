import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String displayName;
  final String email;

  const UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
  });

  Map<String, dynamic> toMap() => <String, dynamic>{
        'uid': uid,
        'displayName': displayName,
        'email': email,
      };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
        uid: map['uid'],
        displayName: map['displayName'],
        email: map['email'],
      );

  UserModel.empty()
      : uid = '',
        displayName = '',
        email = '';

  UserModel copyWith({
    String? uid,
    String? displayName,
    String? email,
  }) =>
      UserModel(
        uid: uid ?? this.uid,
        displayName: displayName ?? this.displayName,
        email: email ?? this.email,
      );
}
