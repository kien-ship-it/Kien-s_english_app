import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gif_view/gif_view.dart';

import '../../../../GlobalData.dart';
import '../../../../models/LessonModel.dart';
import '../../../../services/AIService.dart';
import '../../../../services/store.dart';
import 'CustomRichText.dart';

class AIStory extends StatefulWidget {
  final LessonModel lessonModel;

  const AIStory({super.key, required this.lessonModel});

  @override
  State<AIStory> createState() => _AIStoryState();
}

class _AIStoryState extends State<AIStory> {
  String myStory = "";
  bool isLoading = false;
  String selectedWord = "";
  String wordMeaning = "";
  bool isWordMenuVisible = false;
  @override
  void initState() {
    super.initState();
    if (widget.lessonModel.id != null) {
      myStory = GlobalData.getLatestLesson(widget.lessonModel.id ?? "").story;
    }
    handleStory(); // Ensure this is awaited if needed
  }

  Future handleStory() async {
    if (myStory.isEmpty) {
      setState(() {
        isLoading = true;
      });
      // call api to generate story
      myStory = await AIService.generateStory(widget.lessonModel);

      // assign story
      if (widget.lessonModel.id != null) {
        FireStore.updateStory(widget.lessonModel.id ?? "", myStory);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      myStory = widget.lessonModel.story;
    }
  }

  void onKeywordTap(String keyword) {
    setState(() {
      selectedWord = keyword;
      wordMeaning = widget.lessonModel.listWordModel
          .firstWhere((wordModel) =>
              wordModel.word.toLowerCase() == keyword.toLowerCase())
          .wordMeaning;
      isWordMenuVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFB1DCDF),
        body: Stack(
          children: [
            Positioned(
              top: 20.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      // Handle options action
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50.0,
              left: 16.0,
              right: 16.0,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 200.0,
                  ),
                  child: Text(
                    widget.lessonModel.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 33.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 165.0,
              left: 0.0,
              right: 0.0,
              bottom: 0,
              child: isLoading
                  ? GifView.asset("assets/images/loading_anim.gif")
                  : ParagraphContainer(
                      child: KeywordText(
                        lessonModel: widget.lessonModel,
                        onKeywordTap: onKeywordTap,
                      ),
                    ),
            ),
            if (!isLoading)
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: WordMenu(
                  selectedWord: selectedWord,
                  wordMeaning: wordMeaning,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ParagraphContainer extends StatelessWidget {
  final Widget child;

  const ParagraphContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      padding: const EdgeInsets.only(left: 25, right: 25, top: 30, bottom: 150),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}

class WordMenu extends StatefulWidget {
  final String selectedWord;
  final String wordMeaning;

  const WordMenu(
      {super.key, required this.selectedWord, required this.wordMeaning});

  @override
  State<WordMenu> createState() => _WordMenuState();
}

class _WordMenuState extends State<WordMenu> {
  FlutterTts flutterTts = FlutterTts();

  void initTts() async {
    flutterTts = await flutterTts.setLanguage("en-US");
    log("TTS Language set: $flutterTts");
  }

  @override
  void initState() {
    super.initState();
    initTts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          topRight: Radius.circular(35.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 4,
            blurRadius: 3,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                widget.selectedWord.isNotEmpty
                    ? 'Word: ${widget.selectedWord}'
                    : '',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await flutterTts.speak(widget.selectedWord);
                },
                child: const Icon(
                  Icons.speaker,
                  size: 30,
                ),
              )
            ],
          ),
          const SizedBox(height: 10.0),
          widget.selectedWord.isNotEmpty
              ? Text(
                  'Meaning: ${widget.wordMeaning}',
                  style: const TextStyle(fontSize: 16.0, color: Colors.black54),
                )
              : Container(),
        ],
      ),
    );
  }
}