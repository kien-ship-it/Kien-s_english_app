import 'package:flutter/material.dart';

import '../../../../GlobalData.dart';
import '../../../../models/LessonModel.dart';
import '../../../../services/AIService.dart';
import '../../../../services/FirestoreService.dart';

class AIStory extends StatefulWidget {
  final LessonModel lessonModel;

  const AIStory({super.key, required this.lessonModel});

  @override
  State<AIStory> createState() => _AIStoryState();
}

class _AIStoryState extends State<AIStory> {
  String myStory = "";
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
      setState(() {
        isLoading = true;
      });

      // call API to generate story
      myStory = await AIService.generateStory(widget.lessonModel.listWordModel as LessonModel);

      // assign story
      if (widget.lessonModel.id != null) {
        await FirestoreService().createOrUpdateStory(widget.lessonModel.id ?? "", myStory);
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
            Positioned(
              top: 165.0,
              left: 16.0,
              right: 16.0,
              bottom: 100.0,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ParagraphContainer(content: myStory),
            ),
            Positioned(
              bottom: 20.0,
              left: 16.0,
              right: 16.0,
              child: WordMenu(),
            ),
          ],
        ),
      ),
    );
  }
}

class ParagraphContainer extends StatelessWidget {
  final String content;

  const ParagraphContainer({super.key, required this.content});

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
        child: Text(content, style: const TextStyle(fontSize: 18.0)),
      ),
    );
  }
}

class WordMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 30.0),
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
        side: const BorderSide(width: 1, color: Colors.white),
      ),
    );
  }
}