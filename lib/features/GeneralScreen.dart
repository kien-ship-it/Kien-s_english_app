import 'package:english_app/features/home/home_screen.dart';
import 'package:english_app/features/lesson/LessonScreen.dart';
import 'package:english_app/features/user/UserScreen.dart';
import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:gif_view/gif_view.dart';

import '../Widgets/CustomIcon.dart';

class GeneralScreen extends StatefulWidget {
  final int? settingIndex;

  const GeneralScreen({super.key, this.settingIndex});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  var currentIndex = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.settingIndex ?? 0;
    getData();
  }

  Future getData() async {
    await FireStore.loadUser();
    await FireStore.loadLesson();
    setState(() {
      isLoading = false;
    });
  }

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
    return isLoading
        ? Scaffold(
            body: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  const Opacity(
                    opacity: 0.6,
                    child: ModalBarrier(
                        dismissible: false,
                        color: Colors.white), // Darken screen
                  ),
                  Center(
                    child: GifView.asset("assets/images/loading_anim.gif"),
                  ),
                ],
              ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              body: bodyParser(currentIndex),
              bottomNavigationBar: SnakeNavigationBar.color(
                behaviour: SnakeBarBehaviour.pinned,
                height: 88,
                backgroundColor: Colors.white,
                snakeShape: SnakeShape.indicator,
                selectedItemColor: const Color(0xFFEB6440),
                unselectedItemColor: Colors.black,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                snakeViewColor: Colors.white,
                shadowColor: Colors.black,
                selectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
                unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black),
                currentIndex: currentIndex,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: CustomIcon(icon: Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: CustomIcon(icon: Icons.import_contacts),
                    label: 'Lesson',
                  ),
                  BottomNavigationBarItem(
                    icon: CustomIcon(icon: Icons.person),
                    label: 'User',
                  ),
                ],
              ),
            ),
          );
  }
}
