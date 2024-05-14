import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ALessonScreen extends StatefulWidget {
  final String title;

  const ALessonScreen({super.key, required this.title});

  @override
  State<ALessonScreen> createState() => _ALessonScreenState();
}

class _ALessonScreenState extends State<ALessonScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 50),
        ),
      ),
    ));
  }
}
