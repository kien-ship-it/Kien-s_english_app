import 'package:english_app/GlobalData.dart';
import 'package:flutter/material.dart';

import '../../Widgets/FloatButton.dart';
import '../../services/auth.dart';
import '../authentication/login_screen.dart';
import 'UserBox.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all( 20),
      color: const Color(0xFFEFF5F5),
      child: Stack(
        children: [
          const Positioned(
            top: 0,
            child: const Text(
              "Profile",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 70,
            child: UserBox(
              userModel: GlobalData.user,
            ),
          ),
          Positioned(
            right: 0,
            bottom: 20,
            child: myCustomBtn(
              onTap: () {
                Auth().signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              color: const Color(0xFFFFFFFF),
              icon: Icons.logout,
              iconColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
