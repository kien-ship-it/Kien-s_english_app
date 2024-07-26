import 'package:english_app/models/WordModel.dart';

import '../models/LessonModel.dart';

class Helper {
  List<LessonModel> buildDefaultLesson() {
    List<LessonModel> result = [];
    result = [
      LessonModel(
          title: "Default Lesson 1",
          description: "This is a default lesson",
          isFavorite: false,
          color: "",
          listWordModel: [
            WordModel(
              word: "Hello",
              wordType: "wordType",
              wordMeaning: "Xin chao",
            ),
          ],
          story: ""),
      LessonModel(
          title: "Default Lesson 2",
          description: "This is a default lesson",
          isFavorite: false,
          color: "",
          listWordModel: [
            WordModel(
              word: "Hello",
              wordType: "wordType",
              wordMeaning: "Xin chao",
            ),
          ],
          story: "")
    ];
    return result;
  }
}
