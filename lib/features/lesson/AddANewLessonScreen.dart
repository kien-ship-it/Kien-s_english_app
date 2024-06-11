import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';

import '../../models/LessonModel.dart';

class AddANewLessonScreen extends StatefulWidget {
  const AddANewLessonScreen({super.key});

  @override
  State<AddANewLessonScreen> createState() => _AddANewLessonScreenState();
}

class _AddANewLessonScreenState extends State<AddANewLessonScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "add a new lesson",
                style: TextStyle(fontSize: 30),
              ),
            ),
            TextButton(
              onPressed: () async {
                FireStore.addLesson(LessonModel.dummy()).then((value) {
                  Navigator.pop(context);
                });
              },
              child: Text("Click Here to add a new lesson"),
            ),
          ],
        ),
      ),
    );
  }
}
