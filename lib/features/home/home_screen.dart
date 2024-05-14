import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Widgets/LessonBox.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF5F5),
        body: ListView.builder(
          itemCount: 1, // Ensures only one item in the ListView for the "Home" title
          itemBuilder: (context, index) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(top: 30, bottom: 0, left: 16),
                  child: Align(
                    alignment: FractionalOffset(0, 0.5),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8.0), // Add some space between the title and the container
                LessonBox(),
                LessonBox(),
                LessonBox(),
                LessonBox()
              ],
            );
          },
        ),
      ),
    );
  }
}