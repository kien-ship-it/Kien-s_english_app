import 'package:uuid/uuid.dart';

import 'WordModel.dart';

class LessonModel {
  String? id;
  final String title;
  final String description;
  final bool isLightning;
  final String color;
  final List<WordModel> listWordModel;
  final String story;

  LessonModel({
    this.id,
    required this.title,
    required this.description,
    required this.isLightning,
    required this.color,
    required this.listWordModel,
    required this.story,
  }) {
    id = const Uuid().v4();
  }

  void addNewWord(WordModel wordModel) {
    if (isExistedWord(wordModel.word)) return;
    listWordModel.add(wordModel);
  }

  bool isExistedWord(String word) {
    var res = false;
    for (var element in listWordModel) {
      if (element.word.toLowerCase() == word.toLowerCase()) {
        res = true;
        break;
      }
    }
    return res;
  }

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    List<WordModel> listWordModel = [];
    json['listWordModel'].forEach((element) {
      listWordModel.add(WordModel.fromJson(element));
    });
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isLightning: json['isLightning'],
      color: json['color'],
      listWordModel: listWordModel,
      story: json['story'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isLightning': isLightning,
      'color': color,
      'listWordModel': listWordModel.map((e) => e.toJson()).toList(),
      'story': story,
    };
  }

  factory LessonModel.empty() {
    return LessonModel(
      title: 'Empty Title',
      description: 'Empty Description',
      isLightning: false,
      color: "",
      listWordModel: [],
      story: '',
    );
  }

  factory LessonModel.dummy() {
    return LessonModel(
      id: '1',
      title: "Default Lesson 1",
      description: "This is a default lesson",
      isLightning: false,
      color: "",
      listWordModel: [
        WordModel(
          word: "Hello",
          wordType: "wordType",
          wordMeaning: "Xin chao",
        ),
      ],
      story: "",
    );
  }

  factory LessonModel.copyWith(LessonModel lesson, {String? id}) {
    return LessonModel(
      id: id ?? lesson.id,
      title: lesson.title,
      description: lesson.description,
      isLightning: lesson.isLightning,
      color: lesson.color,
      listWordModel: lesson.listWordModel,
      story: lesson.story,
    );
  }
}
