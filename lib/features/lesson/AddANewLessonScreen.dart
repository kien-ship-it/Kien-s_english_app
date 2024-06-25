import 'package:english_app/Widgets/MyToast.dart';
import 'package:english_app/services/DictionaryService.dart';
import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';

import '../../models/LessonModel.dart';

class AddANewLessonScreen extends StatefulWidget {
  const AddANewLessonScreen({super.key});

  @override
  State<AddANewLessonScreen> createState() => _AddANewLessonScreenState();
}

class _AddANewLessonScreenState extends State<AddANewLessonScreen> {
  LessonModel lesson = LessonModel.empty();
  TextEditingController titleController = TextEditingController();

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
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'New word',
              ),
              onChanged: (value) {},
            ),
            ElevatedButton(
                onPressed: () async {
                  DictionaryService.getWord(titleController.text).then((value) {
                    lesson.addNewWord(value);
                    showToast("Successful");
                  });
                },
                child: const Text("Add")),
            TextButton(
              onPressed: () async {
                FireStore.addLesson(LessonModel.copyWith(lesson)).then((value) {
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
              child: Text("Click Here to add a new lesson"),
            ),
          ],
        ),
      ),
    );
  }
}
