import 'package:flutter/material.dart';
import 'package:english_app/models/LessonModel.dart';
import '../features/lesson/IndividualLesson/ALessonScreen.dart';
import '../services/store.dart';
import '../Widgets/MyToast.dart';

class LessonBox extends StatelessWidget {
  final LessonModel lessonModel;
  final bool isDefaultLesson;

  const LessonBox({
    Key? key,
    required this.lessonModel,
    this.isDefaultLesson = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 197, // Set a fixed height for the container
        decoration: BoxDecoration(
          color: const Color(0xFFBFDEE2),
          borderRadius: BorderRadius.circular(15.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    lessonModel.title,
                    style: const TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 0.5), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.flash_on,
                    color: lessonModel.isLightning
                        ? const Color(0xFFEB6440)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                width: 290, // Set the width to limit the length of each line
                child: Text(
                  lessonModel.description,
                  style: const TextStyle(fontSize: 16.0),
                  overflow: TextOverflow.ellipsis,
                  // Display ellipsis (...) if the text overflows
                  maxLines: 2, // Limit to 2 lines
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (isDefaultLesson) {
                    // Call API to add lesson
                    bool success = await FireStore.addLesson(lessonModel);
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
                        builder: (context) => ALessonScreen(lessonModel: lessonModel),
                      ),
                    );
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFEB6440),
                  ),
                  fixedSize: MaterialStateProperty.all<Size>(
                    const Size(200.0, 45.0),
                  ),
                ),
                child: Text(
                  isDefaultLesson ? "ADD" : "START",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
