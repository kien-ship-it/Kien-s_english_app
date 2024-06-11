import 'package:english_app/features/home/home_screen.dart';
import 'package:english_app/features/lesson/LessonScreen.dart';
import 'package:english_app/features/user/UserScreen.dart';
import 'package:english_app/services/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import '../Widgets/CustomIcon.dart';

class GeneralScreen extends StatefulWidget {
  const GeneralScreen({super.key});

  @override
  State<GeneralScreen> createState() => _GeneralScreenState();
}

class _GeneralScreenState extends State<GeneralScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    FireStore.loadUser();
  }

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
  // const Color(0xFFEED7CF)

  Widget _buildFAB() {
    return Visibility(
      visible: currentIndex == 1,
      child: FloatingActionButton(
        backgroundColor: Colors.orange[200],
        enableFeedback: true,
        shape: const CircleBorder(),
        onPressed: () {
          // Your FAB action here
        },
        child: const Icon(Icons.add, size: 35, color: Colors.black87,),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: bodyParser(currentIndex),
        floatingActionButton: _buildFAB(),
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.pinned,
          height: 88,
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
            color: Colors.black
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black
          ),

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
