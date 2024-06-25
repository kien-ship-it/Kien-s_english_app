import 'package:flutter/material.dart';

import '../../../Widgets/LessonBox.dart';
import '../../../models/LessonModel.dart';

class LessonBoxList extends StatefulWidget {
  final List<LessonModel> lessons;
  bool isDefaultLesson;

  LessonBoxList({
    super.key,
    required this.lessons,
    this.isDefaultLesson = false,
  });

  State<LessonBoxList> createState() => _LessonBoxListState();
}

class _LessonBoxListState extends State<LessonBoxList> {
  @override
  Widget build(BuildContext context) {
    return widget.lessons.isEmpty
        ? const Center(
            child: Text(
              "Empty List",
              style: TextStyle(fontSize: 24),
            ),
          )
        : CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = widget.lessons[index];
                    return LessonBox(
                        lessonModel: item,
                        isDefaultLesson: widget.isDefaultLesson);
                  },
                  childCount:
                      widget.lessons.length, // 4 items + 1 for the blank space
                ),
              ),
            ],
          );
  }
}
