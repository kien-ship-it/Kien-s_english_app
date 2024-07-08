import 'package:flutter_gemini/flutter_gemini.dart';
import '../models/LessonModel.dart';

class AIService {
  static Future<String> generateStory(LessonModel lesson) async {
    if (lesson.story.isNotEmpty) {
      return lesson.story;
    }

    var story = "";

    // Call API to get story
    final gemini = Gemini.instance;

    var res = await gemini.text(
      "Generate a interesting story with the following words, "
          "make sure to write with enough context so the audience can "
          "deduce and differentiate the meaning of the words. "
          "Maximum word count is 100. The audience are english learners "
          "who just encountered the words the first time, "
          "make them easy to understand and interesting to read."
          "Here are the words: "
          "${lesson.listWordModel.map((e) => e.word).join(", ")}",
    );

    story = res?.output ?? "";
    lesson.updateStory(story);  // Save the generated story to the lesson
    return story;
  }
}