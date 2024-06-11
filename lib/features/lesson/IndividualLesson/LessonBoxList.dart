import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../Widgets/LessonBox.dart';
import '../../../models/LessonModel.dart';

class Lessonboxlist extends StatefulWidget {
  final List<LessonModel> lessons;

  const Lessonboxlist({super.key, required this.lessons});

  @override
  State<Lessonboxlist> createState() => _LessonboxlistState();
}

class _LessonboxlistState extends State<Lessonboxlist> {
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
                    );
                  },
                  childCount: widget.lessons.length, // 4 items + 1 for the blank space
                ),
              ),
            ],
          );
  }
}
