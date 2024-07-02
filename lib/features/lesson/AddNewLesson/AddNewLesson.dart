import 'package:english_app/features/lesson/AddNewLesson/topIcons.dart';
import 'package:english_app/services/DictionaryService.dart';
import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/material.dart';
import 'package:english_app/models/WordModel.dart';


class Addnewlesson extends StatefulWidget {
  const Addnewlesson({super.key});

  @override
  State<Addnewlesson> createState() => _AddnewlessonState();
}

class _AddnewlessonState extends State<Addnewlesson> {
  TextEditingController inputWordController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  LessonModel lesson = LessonModel.empty();
  List<WordModel> wordDefinitions = [];
  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();
  bool isEditingTitleOrDescription = false;

  Future<void> addWord() async {
    final word = inputWordController.text.trim();
    if (word.isNotEmpty) {
      try {
        final wordModel = await DictionaryService.getWord(word);
        setState(() {
          lesson.addNewWord(wordModel);
          inputWordController.clear();
        });
      } catch (e) {
        // Handle error, show toast or snackbar
        print("Error fetching word definition: $e");
      }
    }
  }

  void removeWord(WordModel word) {
    setState(() {
      lesson.removeWord(word);
    });
  }

  @override
  void initState() {
    super.initState();
    titleController.text = lesson.title;
    descriptionController.text = lesson.description;

    titleFocusNode.addListener(_handleFocusChange);
    descriptionFocusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      isEditingTitleOrDescription = titleFocusNode.hasFocus || descriptionFocusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    titleFocusNode.removeListener(_handleFocusChange);
    descriptionFocusNode.removeListener(_handleFocusChange);
    titleFocusNode.dispose();
    descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFB1DCDF),
          body: Stack(
            children: [
              TopIcons(lesson: lesson, mounted: mounted),
              Positioned(
                top: 50.0,
                left: 16.0,
                right: 16.0,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 0),
                        constraints: const BoxConstraints(
                          maxWidth: 220,
                        ),
                        child: TextField(
                          focusNode: titleFocusNode,
                          controller: titleController,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (value) {
                            setState(() {
                              lesson = LessonModel.copyWith(lesson, title: value);
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 3,),
                    Center(
                      child: Container(
                          margin: const EdgeInsets.only(top: 0),
                          constraints: const BoxConstraints(
                            maxWidth: 250.0,
                          ),
                          child: TextField(
                            maxLines: 2,
                            focusNode: descriptionFocusNode,
                            controller: descriptionController,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              setState(() {
                                lesson = LessonModel.copyWith(lesson, description: value);
                              });
                            },
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Positioned( //Paragraph box
                  top: 180.0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ParagraphContainer(wordDefinitions: lesson.listWordModel)
              ),
              if (!isEditingTitleOrDescription) Positioned( //Add word box
                bottom: 30,
                left: 20,
                right: 20,
                child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFFFFE3C9),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.4),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 2),
                        )
                      ]
                  ),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: inputWordController,
                    decoration: const InputDecoration(
                      hintText: "Add",
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.add),
                    ),
                    onSubmitted: (_) => addWord(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ParagraphContainer(WordDefinitionList(WordDefinitionPreviewBox))

class ParagraphContainer extends StatefulWidget {
  final List<WordModel> wordDefinitions;

  const ParagraphContainer({required this.wordDefinitions, super.key});

  @override
  State<ParagraphContainer> createState() => _ParagraphContainerState();
}

class _ParagraphContainerState extends State<ParagraphContainer> {
  List<WordModel> get wordDefinitions => widget.wordDefinitions;

  void removeWord(WordModel word) {
    setState(() {
      wordDefinitions.remove(word);
    });
  }

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
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                "Words",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 30),
              child: Scrollbar(
                interactive: true,
                thickness: 4.5,
                radius: const Radius.circular(100),
                thumbVisibility: false,
                child: WordDefinitionList(
                  wordDefinitions: widget.wordDefinitions,
                  onRemove: removeWord,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WordDefinitionList extends StatelessWidget {
  final List<WordModel> wordDefinitions;
  final Function(WordModel) onRemove;

  const WordDefinitionList({
    required this.wordDefinitions,
    required this.onRemove,
    super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        children: wordDefinitions
            .map((word) => WordDefinitionPreviewBox(
          word: word, onRemove: () => onRemove(word),
        ))
            .toList(),
      ),
    );
  }
}

class WordDefinitionPreviewBox extends StatelessWidget {
  final WordModel word;
  final VoidCallback onRemove; // Add the onRemove parameter

  const WordDefinitionPreviewBox({
    required this.word,
    required this.onRemove,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        padding: const EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word,
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 3),
                Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  child: Text(
                    word.wordMeaning,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  height: 30,
                  width: 30,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.white,
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