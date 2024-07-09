import 'package:flutter/material.dart';

import '../../../Widgets/ProgressBar.dart';
import '../../../models/LessonModel.dart';
import '../learn/AI Story/AIStory.dart';
import '../learn/Flashcards/Flashcards.dart';
import '../learn/Multiple Choice/MultipleChoice.dart';
import 'AppBar/SliverTitleAppBar.dart';
import 'LearnBox.dart';
import 'WordBox.dart';

class ALessonScreen extends StatefulWidget {
  final LessonModel lessonModel;

  const ALessonScreen({super.key, required this.lessonModel});

  @override
  State<ALessonScreen> createState() => _ALessonScreenState();
}

class _ALessonScreenState extends State<ALessonScreen> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    double progressValue = 0.7;
    double paddingProgressBar = 30;
    double progressWidth =
        (MediaQuery.of(context).size.width - 2 * paddingProgressBar);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5F5),
        body: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPersistentHeader(
              delegate: SliverTitleAppBar(
                  title: widget.lessonModel.title,
                  id: widget.lessonModel.id ?? ""),
              pinned: true,
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 0, left: 35),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Progress: 17/20",
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: ProgressBar(
                paddingProgressBar: paddingProgressBar,
                progressWidth: progressWidth,
                progressValue: progressValue,
                backgroundColor: const Color(0xFFB1DCDF),
                progressColor: const Color(0xFF497174),
              ),
            ),
            SliverToBoxAdapter(
              child: WordBox(
                words: widget.lessonModel.listWordModel,
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 40, left: 30),
                child: Text(
                  "Learn",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LearnBox(
                      title: "Flashcard",
                      icon: Icons.collections_bookmark,
                      distanceIconText: 13,
                      color: const Color(0xFFEB6440),
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Flashcards()),
                        );
                      },
                    ),
                    LearnBox(
                      title: "AI Story",
                      icon: Icons.ac_unit_outlined,
                      distanceIconText: 13,
                      color: const Color(0xFF497174),
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AIStory(
                                    lessonModel: widget.lessonModel,
                                  )),
                        );
                      },
                    ),
                    LearnBox(
                      title: "Multiple Choice",
                      icon: Icons.format_list_bulleted,
                      distanceIconText: 6,
                      color: const Color(0xFFEB6440),
                      onTapAction: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MultipleChoice()),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 30,
              ),
            )
          ],
        ),
      ),
    );
  }
}
