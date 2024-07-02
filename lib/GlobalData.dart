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

  static void addStoryToLessonById(String id, String story) {
    for (int i = 0; i < listPersonalLesson.length; i++) {
      LessonModel e = listPersonalLesson[i];
      if (e.id == id) {
        var modifiedLesson = e.copyWith(story: story);
        listPersonalLesson[i] = modifiedLesson;
        break;
      }
    }
  }

  static LessonModel getLatestLesson(String id) {
    for (LessonModel e in listPersonalLesson) {
      if (e.id == id) {
        return e;
      }
    }
    return LessonModel.empty();
  }
}