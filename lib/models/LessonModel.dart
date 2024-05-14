import 'dart:ui';

class LessonModel {
  final String title;
  final String description;
  final bool isLightning;
  final Color color;

  LessonModel(
      {required this.title,
      required this.description,
      required this.isLightning,
      required this.color});
}
