import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String email;
  String userName;

  UserModel({required this.id, required this.email, required this.userName});

  factory UserModel.fromAuth(User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      userName: ''
    );
  }

  factory UserModel.fromString(Map<dynamic, dynamic> user) {
    return UserModel(
      id: user['id'],
      email: user['email'],
        userName: user['userName']
    );
  }

  factory UserModel.empty() {
    return UserModel(
      id: '',
      email: '',
      userName: ''
    );
  }

  factory UserModel.fromCloud(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
        userName: json['userName'] ?? ''
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName':userName
    };
  }
}