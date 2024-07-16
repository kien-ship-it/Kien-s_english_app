import 'package:uuid/uuid.dart';

import 'WordModel.dart';

class LessonModel {
  String? id;
  final String title;
  final String description;
  final bool isLightning;
  final String color;
  final List<WordModel> listWordModel;
  String story;

  LessonModel({
    this.id,
    required this.title,
    required this.description,
    required this.isLightning,
    required this.color,
    required this.listWordModel,
    required this.story,
  });

  LessonModel copyWith({
    String? id,
    String? title,
    String? description,
    bool? isLightning,
    String? color,
    List<WordModel>? listWordModel,
    String? story,
  }) {
    return LessonModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isLightning: isLightning ?? this.isLightning,
      color: color ?? this.color,
      listWordModel: listWordModel ?? this.listWordModel,
      story: story ?? this.story,
    );
  }

  bool addNewWord(WordModel wordModel) {
    if (isExistedWord(wordModel.word)) return false;
    listWordModel.add(wordModel);
    return true;
  }

  void removeWord(WordModel wordModel) {
    listWordModel.remove(wordModel);
  }

  bool isExistedWord(String word) {
    return listWordModel.any((element) => element.word.toLowerCase() == word.toLowerCase());
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
      id: const Uuid().v4(),
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

  factory LessonModel.copyWith(LessonModel lesson, {
    String? id,
    bool? isLightning,
    String? color,
    List<WordModel>? listWordModel,
    String? story,
    String? title,
    String? description,
  }) {
    return LessonModel(
      id: id ?? lesson.id,
      title: title ?? lesson.title,
      description: description ?? lesson.description,
      isLightning: isLightning ?? lesson.isLightning,
      color: color ?? lesson.color,
      listWordModel: listWordModel ?? lesson.listWordModel,
      story: story ?? lesson.story,
    );
  }

  // Method to update the story
  void updateStory(String newStory) {
    story = newStory;
  }
}
