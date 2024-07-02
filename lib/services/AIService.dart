import 'package:flutter_gemini/flutter_gemini.dart';

import '../models/WordModel.dart';

class AIService {
  static Future<String> generateStory(List<WordModel> words) async {
    var story = "";

    // call API to get story
    final gemini = Gemini.instance;

    var res = await gemini.text(
        "I'm learning english, please help me to generate a simple story about 150 words"
        "based on below words: ${words.map((e) => e.word).join(", ")}");

    story = res?.output ?? "";
    return story;
  }
}
