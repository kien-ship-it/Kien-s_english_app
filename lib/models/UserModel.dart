import 'package:english_app/models/LessonModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'WordModel.dart';

class UserModel {
  final String id;
  final String fullName;
  final List<LessonModel> listLesson;

  UserModel({
    required this.id,
    required this.listLesson,
    required this.fullName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'listLesson': listLesson.map((e) => e.toJson()).toList(),
    };
  }

  factory UserModel.empty() {
    return UserModel(
      id: FirebaseAuth.instance.currentUser!.uid,
      listLesson: [],
      fullName: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      listLesson: List<LessonModel>.from(
          json['listLesson'].map((e) => LessonModel.fromJson(e))),
      fullName: json['fullName'],
    );
  }

  factory UserModel.clone(UserModel user){
    return UserModel(
        id: user.id,
        listLesson: user.listLesson,
        fullName: user.fullName
    );
  }
}
