import 'package:english_app/models/LessonModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../GlobalData.dart';
import '../../Widgets/MinimalLessonWidget.dart';

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

    List<Widget> listWidget = [];
    for (var e in listLesson) {
      listWidget.add(
        // UI need to be decorated
        MinimalLessonWidget(
          lessonModel: e,
        ),
      );
    }
    return SafeArea(
      child: ListView(
        children: [Text("HOME"), ...listWidget],
    ));
  }
}
