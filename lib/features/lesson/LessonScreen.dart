import 'package:english_app/features/GlobalData.dart';
import 'package:flutter/material.dart';

import 'IndividualLesson/LessonBoxList.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  bool isChooseMyLesson = true;

  Widget topController(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        customButton("My lessons", width, isSelected: isChooseMyLesson,
            onTap: () {
          setState(() {
            isChooseMyLesson = true;
          });
        }),
        customButton("Lessons", width, isSelected: !isChooseMyLesson,
            onTap: () {
          setState(() {
            isChooseMyLesson = false;
          });
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        color: const Color(0xFFEFF5F5),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 30),
            topController(width),
            const SizedBox(height: 10),
            Expanded(
                child: Lessonboxlist(
              lessons: isChooseMyLesson
                  ? GlobalData.user.listPersonalLesson
                  : GlobalData.user.listDefaultLesson,
            )),
          ],
        ),
      ),
    );
  }

  Widget customButton(String title, double width,
      {required bool isSelected, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            width: width / 2 - 35,
            height: 4,
            color: isSelected ? const Color(0xFFEB6440) : Colors.black,
          ),
        ],
      ),
    );
  }
}
