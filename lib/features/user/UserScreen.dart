import 'package:english_app/features/authentication/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LogoutButton.dart';
import 'UserBox.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: const Color(0xFFEFF5F5),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0), // Added margin
                padding: const EdgeInsets.all(8.0), // Internal padding
                child: const Text(
                  "Profile",
                  textAlign: TextAlign.left, // Align text to the left
                  style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                ),
              ),
              const UserBox(),
              const LogOutButton(),
            ],
          ),
      ),
      );
  }
}

