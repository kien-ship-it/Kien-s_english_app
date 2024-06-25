import 'package:english_app/GlobalData.dart';
import 'package:flutter/material.dart';

import 'AddANewLessonScreen.dart';
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
      child: Stack(
        children: [
          Positioned(
            child: Container(
              color: const Color(0xFFEFF5F5),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  topController(width),
                  const SizedBox(height: 10),
                  Expanded(
                      child: LessonBoxList(
                    lessons: isChooseMyLesson
                        ? GlobalData.listPersonalLesson
                        : GlobalData.listDefaultLesson,
                    isDefaultLesson: !isChooseMyLesson,
                  )),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: buildAddBtn(),
          ),
        ],
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

  Widget buildAddBtn() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4), // Shadow color with opacity
            spreadRadius: 2, // Spread value
            blurRadius: 3, // Blur value
          ),
        ],
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xFFEB6440)),
          fixedSize: WidgetStateProperty.all(const Size(60, 60)),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(0),
          ),
        ),
        onPressed: () {
          Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddANewLessonScreen()))
              .then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add, size: 30, color: Colors.black),
      ),
    );
  }
}
