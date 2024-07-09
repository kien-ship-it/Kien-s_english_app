import 'package:flutter/material.dart';
import '../../../../GlobalData.dart';
import '../../../../models/LessonModel.dart';
import '../../../../services/AIService.dart';
import '../../../../services/FirestoreService.dart';
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

  Future<void> handleStory() async {
    if (myStory.isEmpty) {
      setState(() {
        isLoading = true;
      });

      // call API to generate story
      try {
        myStory = await AIService.generateStory(widget.lessonModel);

        // assign story
        if (widget.lessonModel.id != null) {
          await FirestoreService().createOrUpdateStory(widget.lessonModel.id ?? "", myStory);
        }
      } catch (e) {
        // Handle error here
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        myStory = widget.lessonModel.story;
      });
    }
  }

  void onKeywordTap(String keyword) {
    setState(() {
      selectedWord = keyword;
      wordMeaning = widget.lessonModel.listWordModel
          .firstWhere((wordModel) => wordModel.word.toLowerCase() == keyword.toLowerCase())
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
                  child: const Text(
                    'A Doubtful Discovery',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
              bottom: 100.0,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ParagraphContainer(
                child: KeywordText(
                  lessonModel: widget.lessonModel,
                  onKeywordTap: onKeywordTap,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: AnimatedOpacity(
                opacity: isWordMenuVisible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 300),
                child: Visibility(
                  visible: isWordMenuVisible,
                  child: WordMenu(
                    selectedWord: selectedWord,
                    wordMeaning: wordMeaning,
                  ),
                ),
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
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}

class WordMenu extends StatelessWidget {
  final String selectedWord;
  final String wordMeaning;

  const WordMenu({super.key, required this.selectedWord, required this.wordMeaning});

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
          Center(
            child: Text(
              selectedWord.isNotEmpty ? 'Word: $selectedWord' : '',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          selectedWord.isNotEmpty
              ? Text(
            'Meaning: $wordMeaning',
            style: const TextStyle(fontSize: 16.0, color: Colors.black54),
          )
              : Container(),
        ],
      ),
    );
  }
}
