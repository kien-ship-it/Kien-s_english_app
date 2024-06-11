import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
    };
  }

  factory UserModel.empty() {
    return UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      fullName: '',
      email: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      fullName: json['fullName'],
    );
  }

  factory UserModel.clone(UserModel user) {
    return UserModel(
        email: user.email,
        id: user.id,
        fullName: user.fullName);
  }

  // initialize data for new user
  factory UserModel.init(String fullName, String email) {
    return UserModel(
      email: email,
      id: Auth().getUserId(),
      fullName: fullName,
    );
  }

  @override
  String toString() {
    return toJson().toString();
  }
}
