import 'package:english_app/models/UserModel.dart';

import 'models/LessonModel.dart';

class GlobalData {
  static UserModel user = UserModel.empty();
  static List<LessonModel> listDefaultLesson = [];
  static List<LessonModel> listPersonalLesson = [];

  static bool isExistLesson(String? lessonId) {
    if (lessonId == null) {
      return true;
    }
    return listPersonalLesson.any((element) => element.id == lessonId);
  }
}