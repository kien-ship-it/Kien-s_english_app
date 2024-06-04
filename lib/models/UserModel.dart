import 'package:english_app/models/LessonModel.dart';
import 'package:english_app/services/Helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth.dart';

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final List<LessonModel> listPersonalLesson;
  final List<LessonModel> listDefaultLesson;

  UserModel({
    required this.id,
    required this.listPersonalLesson,
    required this.fullName,
    required this.listDefaultLesson,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'listPersonalLesson': listPersonalLesson.map((e) => e.toJson()).toList(),
      'listDefaultLesson':
          listDefaultLesson.map((e) => e.toJson()).toList(),
      'email': email,
    };
  }

  factory UserModel.empty() {
    return UserModel(
      listDefaultLesson: [],
      id: FirebaseAuth.instance.currentUser!.uid,
      listPersonalLesson: [],
      fullName: '',
      email: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      id: json['id'],
      listPersonalLesson: List<LessonModel>.from(
          json['listPersonalLesson'].map((e) => LessonModel.fromJson(e))),
      fullName: json['fullName'],
      listDefaultLesson: List<LessonModel>.from(
          json['listDefaultLesson'].map((e) => LessonModel.fromJson(e))),
    );
  }

  factory UserModel.clone(UserModel user) {
    return UserModel(
        email: user.email,
        id: user.id,
        listPersonalLesson: user.listPersonalLesson,
        listDefaultLesson: user.listDefaultLesson,
        fullName: user.fullName);
  }

  // initialize data for user
  factory UserModel.init(String fullName, String email) {
    return UserModel(
      email: email,
      id: Auth().getUserId(),
      listDefaultLesson: Helper().buildDefaultLesson(),
      listPersonalLesson: [],
      fullName: fullName,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return toJson().toString();
  }
}
