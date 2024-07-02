import 'dart:developer';

import 'package:english_app/GlobalData.dart';
import 'package:english_app/models/LessonModel.dart';
import 'package:english_app/services/AIService.dart';
import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';

class AIStory extends StatefulWidget {
  final LessonModel lessonModel;

  const AIStory({super.key, required this.lessonModel});

  @override
  State<AIStory> createState() => _AIStoryState();
}

class _AIStoryState extends State<AIStory> {
  var myStory = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.lessonModel.id != null) {
      myStory = GlobalData.getLatestLesson(widget.lessonModel.id ?? "").story;
    }
    handleStory();
  }

  Future handleStory() async {
    if (myStory.isEmpty) {
      log("Here");
      setState(() {
        isLoading = true;
      });
      // call api to generate story
      myStory = await AIService.generateStory(widget.lessonModel.listWordModel);

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
            const Positioned(
              top: 165.0,
              left: 0,
              right: 0,
              bottom: 100.0,
              // Ensure space for the word box
              child: ParagraphContainer(),
            ),
            isLoading
                ? const CircularProgressIndicator()
                : Positioned(
                    top: 165.0,
                    left: 0,
                    right: 0,
                    bottom: 160.0,
                    child: Text(myStory)),
            // const Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: WordMenu(),
            // ),
          ],
        ),
      ),
    );
  }
}

class ParagraphContainer extends StatelessWidget {
  const ParagraphContainer({super.key});

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
    );
  }
}

class ScrollableParagraph extends StatelessWidget {
  const ScrollableParagraph({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      child: SingleChildScrollView(
        child: RichText(
          textAlign: TextAlign.justify,
          text: const TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 18),
            children: [
              TextSpan(
                text: 'Professor Hernandez peered into the telescope, a frown '
                    'creasing her brow. '
                    'The data she was collecting appeared to be an ',
              ),
              TextSpan(
                text: 'aberration',
                style: TextStyle(
                    color: Color(0xFFEB6440), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ', a deviation from the expected pattern. '
                    'The faint celestial object shouldn\'t have been there '
                    'according to established astronomical models. '
                    'Her initial excitement was replaced with a ',
              ),
              TextSpan(
                text: 'dubious',
                style: TextStyle(
                  color: Color(0xFFEB6440),
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextSpan(
                text: ' feeling. Could this be a breakthrough, or an error in '
                    'the instrument?\n\n'
                    'Professor Hernandez was known for her ',
              ),
              TextSpan(
                text: 'diligence',
                style: TextStyle(
                    color: Color(0xFFEB6440), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: '. She meticulously reviewed the data, then spent days '
                    'recalibrating the telescope. '
                    'Finally, she felt confident enough to share her findings '
                    'with a colleague, Dr. Reyes. '
                    'Dr. Reyes, known for his ',
              ),
              TextSpan(
                text: 'benevolent',
                style: TextStyle(
                    color: Color(0xFFEB6440), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' nature, listened patiently as Professor Hernandez '
                    'explained the anomaly. '
                    'He then offered to collaborate on further observations, '
                    'hoping to ',
              ),
              TextSpan(
                text: 'conciliate ',
                style: TextStyle(
                    color: Color(0xFFEB6440), fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: 'any conflicting data and get to the truth.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordMenu extends StatelessWidget {
  const WordMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 30),
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
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Words',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Center(
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              alignment: WrapAlignment.center,
              children: [
                _buildWordChip('Aberration'),
                _buildWordChip('Dubious'),
                _buildWordChip('Diligence'),
                _buildWordChip('Benevolent'),
                _buildWordChip('Conciliate'),
                _buildWordChip('Aberration'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordChip(String word) {
    return Chip(
      label: Text(word),
      labelStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: const Color(0xFFE8E8E8),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100.0),
          side: const BorderSide(width: 1, color: Colors.white)),
    );
  }
}
