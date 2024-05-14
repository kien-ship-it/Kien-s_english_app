import 'package:english_app/features/lesson/ALessonScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/LessonBox.dart';

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
        customButton(
            isChooseMyLesson ? Colors.green : Colors.grey, "My Lessons", width,
            onTap: () {
          setState(() {
            isChooseMyLesson = true;
          });
        }),
        Spacer(),
        customButton(isChooseMyLesson ? Colors.grey : Colors.green,
            "Explore Lessons", width, onTap: () {
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
      alignment: Alignment.center,
      child: Column(
        children: [
          topController(width),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => LessonBox(
                boxTitle: 'SAT 1000+',
                boxDescription: '1000 most common advanced SAT vocabulary',
                lessonBoxColor: Colors.lightBlue,
                lightning: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ALessonScreen(title: "SAT++ ${index + 1}")),
                  );
                },
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    ));
  }
}

Widget customButton(Color color, String title, double width,
    {required Function onTap}) {
  return Container(
    width: width / 2,
    decoration: BoxDecoration(color: color),
    child: TextButton(
      onPressed: () => onTap(),
      child: Text(
        title,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    ),
  );
}
