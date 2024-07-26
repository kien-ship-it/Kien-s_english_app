import 'package:uuid/uuid.dart';

import 'WordModel.dart';

class LessonModel {
  String? id;
  final String title;
  final String description;
  final bool isFavorite;
  final String color;
  final List<WordModel> listWordModel;
  String story;
  late String latestOpenedDate;

  LessonModel({
    this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.color,
    required this.listWordModel,
    required this.story,
    this.latestOpenedDate = "",
  }) {
    latestOpenedDate = DateTime.now().toString();
    id ??= const Uuid().v4();
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
    return listWordModel
        .any((element) => element.word.toLowerCase() == word.toLowerCase());
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
      isFavorite: json['isLightning'],
      color: json['color'],
      listWordModel: listWordModel,
      story: json['story'],
      latestOpenedDate: json['latestOpenedDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isLightning': isFavorite,
      'color': color,
      'listWordModel': listWordModel.map((e) => e.toJson()).toList(),
      'story': story,
      'latestOpenedDate': latestOpenedDate
    };
  }

  factory LessonModel.empty() {
    return LessonModel(
      title: 'Empty Title',
      description: 'Empty Description',
      isFavorite: false,
      color: "",
      listWordModel: [],
      story: '',
      id: const Uuid().v4(),
      latestOpenedDate: DateTime.now().toIso8601String(),
    );
  }

  factory LessonModel.dummy() {
    return LessonModel(
      id: '1',
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
      story: "",
      latestOpenedDate: DateTime.now().toIso8601String(),
    );
  }

  factory LessonModel.copyWith(
    LessonModel lesson, {
    String? id,
    bool? isLightning,
    String? color,
    List<WordModel>? listWordModel,
    String? story,
    String? title,
    String? description,
    String? latestOpenedDate,
  }) {
    return LessonModel(
      id: id ?? lesson.id,
      title: title ?? lesson.title,
      description: description ?? lesson.description,
      isFavorite: isLightning ?? lesson.isFavorite,
      color: color ?? lesson.color,
      listWordModel: listWordModel ?? lesson.listWordModel,
      story: story ?? lesson.story,
      latestOpenedDate: latestOpenedDate ?? lesson.latestOpenedDate,
    );
  }

  // Method to update the story
  void updateStory(String newStory) {
    story = newStory;
  }
}
