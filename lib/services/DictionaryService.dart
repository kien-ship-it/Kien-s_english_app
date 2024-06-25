import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';

import '../models/WordModel.dart';

class DictionaryService {
  static Future<WordModel> getWord(String word) async {
    var meaning =
        await GoogleTranslator().translate(word, from: 'en', to: 'vi');
    var wordType = await getWordTypes(word);
    return WordModel(
        word: word, wordType: wordType.first, wordMeaning: meaning.text);
  }
}

Future<List<String>> getWordTypes(String word) async {
  final url = 'https://api.dictionaryapi.dev/api/v2/entries/en/$word';

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);

    // Check if data is not empty and has meanings
    if (data.isNotEmpty && data[0]['meanings'] != null) {
      final List<dynamic> meanings = data[0]['meanings'];

      // Extract partOfSpeech from meanings
      List<String> wordTypes = [];
      for (var meaning in meanings) {
        if (meaning['partOfSpeech'] != null) {
          wordTypes.add(meaning['partOfSpeech']);
        }
      }

      return wordTypes;
    } else {
      throw Exception('No meanings found for the word.');
    }
  } else {
    throw Exception('Failed to load word definitions');
  }
}
