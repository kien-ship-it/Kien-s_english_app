import 'package:flutter/material.dart';

import '../../../Widgets/MyToast.dart';
import '../../../models/LessonModel.dart';
import '../../../services/store.dart';

class TopIcons extends StatelessWidget {
  const TopIcons({
    super.key,
    required this.lesson,
    required this.mounted,
  });

  final LessonModel lesson;
  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35),
                color: Colors.green,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(1, 1),
                  )
                ]
            ),
            width: 40,
            height: 40,
            child: IconButton(
              icon: const Icon(Icons.done, color: Colors.white),
              onPressed: () async {
                await FireStore.addLesson(lesson).then((value) {
                  if (value) {
                    showToast("Successful");
                  } else {
                    showToast("Failed");
                  }
                  if (mounted) {
                    Navigator.pop(context);
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}