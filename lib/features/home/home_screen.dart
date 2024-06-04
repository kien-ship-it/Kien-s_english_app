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
      child: Container(
        color: const Color(0xFFEFF5F5),
        child: ListView.builder(
          itemCount: 1, // Ensures only one item in the ListView for the "Home" title
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0), // Added margin
                  padding: const EdgeInsets.all(8.0), // Internal padding
                  child: const Text(
                    "Home",
                    textAlign: TextAlign.left, // Align text to the left
                    style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8.0), // Add some space between the title and the container
              ],
            );
          },
        ),
      ),
    );
  }
}

class LessonBoxList {
}