class WordModel {
  final String word;
  final String wordType;
  final String wordMeaning;

  WordModel({
    required this.word,
    required this.wordType,
    required this.wordMeaning,
  });

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'wordType': wordType,
      'wordMeaning': wordMeaning,
    };
  }

  factory WordModel.empty() {
    return WordModel(
      word: '',
      wordType: '',
      wordMeaning: '',
    );
  }

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      word: json['word'],
      wordType: json['wordType'],
      wordMeaning: json['wordMeaning'],
    );
  }

  // to JSON function
  Map<String, dynamic> toJSon() {
    return {
      'word': word,
      'wordType': wordType,
      'wordMeaning': wordMeaning,
    };
  }
}
