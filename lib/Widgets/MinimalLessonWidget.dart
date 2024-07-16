import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/material.dart';

class MinimalLessonWidget extends StatefulWidget {
  final LessonModel lessonModel;

  const MinimalLessonWidget({super.key, required this.lessonModel});

  @override
  State<MinimalLessonWidget> createState() => _MinimalLessonWidgetState();
}

class _MinimalLessonWidgetState extends State<MinimalLessonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.lessonModel.title),
    );
  }
}
