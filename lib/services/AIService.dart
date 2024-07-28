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
          "make sure to write with enough context around the words "
          "so the audience can "
          "deduce and differentiate the meaning of the words. "
          "Maximum word count is 120. The audience are english learners "
          "who just encountered the words the first time,"
          "make the story easy to understand and interesting to read."
          "Do not make the given words a name of a character in the story or "
          "put them in double quotation mark."
          "Here are the words (the story must contain all the words given): "
          "${lesson.listWordModel.map((e) => e.word).join(", ")}",
    );

    story = res?.output ?? "";
    lesson.updateStory(story);  // Save the generated story to the lesson
    return story;
  }
}
