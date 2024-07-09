import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../models/LessonModel.dart';
import '../../../../models/WordModel.dart';

class KeywordText extends StatefulWidget {
  final LessonModel lessonModel;
  final ValueChanged<String> onKeywordTap;

  const KeywordText({super.key, required this.lessonModel, required this.onKeywordTap});

  @override
  State<KeywordText> createState() => _KeywordTextState();
}

class _KeywordTextState extends State<KeywordText> {
  Map<String, String> keywordInfo = {};
  String text = "";

  @override
  void initState() {
    super.initState();
    keywordInfo = buildWordMap(widget.lessonModel.listWordModel);
    text = widget.lessonModel.story;
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    text.splitMapJoin(
      RegExp(buildRegExp(widget.lessonModel.listWordModel)),
      onMatch: (Match match) {
        String keyword = match.group(0)!;
        textSpans.add(
          TextSpan(
            text: keyword,
            style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                widget.onKeywordTap(keyword);
              },
          ),
        );
        return keyword;
      },
      onNonMatch: (String nonMatch) {
        textSpans.add(TextSpan(text: nonMatch));
        return nonMatch;
      },
    );

    return Center(
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          children: textSpans,
        ),
      ),
    );
  }

  Map<String, String> buildWordMap(List<WordModel> listWordModel) {
    Map<String, String> wordMap = {};
    for (WordModel wordModel in listWordModel) {
      wordMap[wordModel.word.toLowerCase()] =
          wordModel.wordMeaning.toLowerCase();
    }
    return wordMap;
  }

  String buildRegExp(List<WordModel> listWordModel) {
    String regExp = r'\b(';
    regExp += listWordModel
        .map((wordModel) => RegExp.escape(wordModel.word.toLowerCase()))
        .join('|');
    regExp += r')\b';
    return regExp;
  }
}
