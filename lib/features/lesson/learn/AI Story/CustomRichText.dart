import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../models/WordModel.dart';

class KeywordText extends StatefulWidget {
  final LessonModel lessonModel;

  const KeywordText({super.key, required this.lessonModel});

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
            style:
                const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _showKeywordInfo(context, keyword);
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
        text: TextSpan(
          style: TextStyle(color: Colors.black, fontSize: 18),
          children: textSpans,
        ),
      ),
    );
  }

  void _showKeywordInfo(BuildContext context, String keyword) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(keyword),
          content: Text(keywordInfo[keyword]!),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
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
        .map((wordModel) => wordModel.word.toLowerCase())
        .join('|');
    regExp += r')\b';
    return regExp;
  }
}
