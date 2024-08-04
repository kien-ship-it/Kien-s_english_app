import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/LessonModel.dart';

class Helper {
  Future<List<LessonModel>> buildDefaultLesson() async {
    List<LessonModel> result = [];
    String jsonString = await rootBundle.loadString('assets/data/lessons.json');
    final jsonData = jsonDecode(jsonString);
    for (var e in jsonData["data"]) {
      result.add(LessonModel.fromJson(e));
    }
    return result;
  }
}
