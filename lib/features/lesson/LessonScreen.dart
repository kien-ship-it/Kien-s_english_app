import 'package:english_app/GlobalData.dart';
import 'package:english_app/features/lesson/AddNewLesson/AddNewLesson.dart';
import 'package:english_app/features/lesson/IndividualLesson/LessonBoxList.dart';
import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/material.dart';

import '../../Widgets/FloatButton.dart';
import '../../Widgets/MyToast.dart';
import '../../services/store.dart';
import 'IndividualLesson/ALessonScreen.dart';

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
                      onTapLesson: (LessonModel lesson) async {
                        if (!isChooseMyLesson) {
                          // Call API to add lesson
                          bool success = await FireStore.addLesson(lesson);
                          if (success) {
                            showToast("Success");
                          } else {
                            showToast("Failed");
                          }
                        } else {
                          // Navigate to ALessonScreen with lessonModel
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ALessonScreen(lessonModel: lesson),
                            ),
                          ).then((value) => setState(() {
                                // update time
                                FireStore.updateLatestOpenedDateById(
                                    lesson.id ?? "",
                                    DateTime.now().toIso8601String());
                              }));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: myCustomBtn(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNewLesson()),
                ).then((value) {
                  setState(() {});
                });
              },
              color: const Color(0xFFEB6440),
              icon: Icons.add,
            ),
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
}
