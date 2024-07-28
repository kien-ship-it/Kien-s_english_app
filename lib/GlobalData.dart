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
        var modifiedLesson = LessonModel.copyWith(e, story: story);
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

  static void removeLessonById(String id) {
    for (var i = 0; i < listPersonalLesson.length; i++) {
      if (listPersonalLesson[i].id == id) {
        listPersonalLesson.removeAt(i);
        break;
      }
    }
  }

  static void updateLesson(LessonModel lesson) {
    for (var i = 0; i < listPersonalLesson.length; i++) {
      if (listPersonalLesson[i].id == lesson.id) {
        listPersonalLesson[i] = lesson;
        break;
      }
    }
  }

  static void updateLatestOpenedDateById(String lessonId, String date) {
    for (var i = 0; i < listPersonalLesson.length; i++) {
      if (listPersonalLesson[i].id == lessonId) {
        listPersonalLesson[i].latestOpenedDate = date;
        break;
      }
    }
  }

  static void updateISFavoriteById(String lessonId) {
    for (var i = 0; i < listPersonalLesson.length; i++) {
      if (listPersonalLesson[i].id == lessonId) {
        listPersonalLesson[i].isFavorite = !listPersonalLesson[i].isFavorite;
        break;
      }
    }
  }

  static List<LessonModel> getListPersonalLessonSortByTime() {
    List<LessonModel> result = [];
    for (var e in listPersonalLesson) {
      result.add(e);
    }
    result.sort((a, b) => b.latestOpenedDate.compareTo(a.latestOpenedDate));
    return result;
  }

  static List<LessonModel> getListFavoriteLesson() {
    List<LessonModel> result = [];
    for (var e in listPersonalLesson) {
      if (e.isFavorite) {
        result.add(e);
      }
    }
    return result;
  }
}
