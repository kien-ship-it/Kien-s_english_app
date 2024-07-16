import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../GlobalData.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<LessonModel> listLesson = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listLesson = GlobalData.getListPersonalLessonSortByTime();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0),
            // Added margin
            padding: const EdgeInsets.all(8.0),
            // Internal padding
            child: const Text(
              "Home",
              textAlign: TextAlign.left, // Align text to the left
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            height: height * 5 / 6,
            child: ListView.builder(
              itemBuilder: (context, index) {
                // decorate
                return Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(listLesson[index].title),
                );
              },
              itemCount: listLesson.length,
            ),
          )
        ],
      ),
    );
  }
}
