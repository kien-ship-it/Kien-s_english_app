import 'package:english_app/features/home/home_screen.dart';
import 'package:english_app/features/lesson/LessonScreen.dart';
import 'package:english_app/features/user/UserScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

import '../Widgets/CustomIcon.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  var currentIndex = 0;

  Widget bodyParser(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const LessonScreen();
      case 2:
        return const UserScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: bodyParser(currentIndex),
          bottomNavigationBar: SnakeNavigationBar.color(
            behaviour: SnakeBarBehaviour.pinned,
            snakeShape: SnakeShape.indicator,
            selectedItemColor: Colors.red,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            snakeViewColor: Colors.amber,
            items: [
              BottomNavigationBarItem(
                  icon: CustomIcon(icon: Icons.home), label: 'home'),
              BottomNavigationBarItem(
                  icon: CustomIcon(icon: Icons.book), label: 'tickets'),
              BottomNavigationBarItem(
                  icon: CustomIcon(icon: Icons.supervised_user_circle_outlined),
                  label: 'tickets'),
            ],
          )),
    );
  }
}
