
import 'WordModel.dart';

class LessonModel {
  final String title;
  final String description;
  final bool isLightning;
  final String color;
  final List<WordModel> listWordModel;
  final String story;

  LessonModel({
    required this.title,
    required this.description,
    required this.isLightning,
    required this.color,
    required this.listWordModel,
    required this.story,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    List<WordModel> listWordModel = [];
    json['listWordModel'].forEach((element) {
      listWordModel.add(WordModel.fromJson(element));
    });
    return LessonModel(
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
      title: '',
      description: '',
      isLightning: false,
      color: "",
      listWordModel: [],
      story: '',
    );
  }
}
