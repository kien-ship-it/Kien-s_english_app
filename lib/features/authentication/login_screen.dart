import 'dart:developer';

import 'package:english_app/features/authentication/signup_screen.dart';
import 'package:english_app/features/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final String title;

  const LoginScreen({
    super.key,
    required this.title,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool isAllFilled = false;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    emailTextController.addListener(updateButtonState);
    passwordTextController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isAllFilled = emailTextController.text.isNotEmpty &&
          passwordTextController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F5),
      body: SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Login",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.grey.withOpacity(0.5),
                      offset: const Offset(0, 1.5),
                      blurRadius: 5,
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // Adjust border radius as needed
                color: Colors.white,
                // Set background color of the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                      // Remove default underline border
                      contentPadding:
                          EdgeInsets.all(15), // Adjust padding as needed
                    ),
                    controller: emailTextController,
                  ),
                  const Divider(height: 1, color: Colors.grey),
                  // Add a divider between email and password fields
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none,
                            // Remove default underline border
                            contentPadding:
                                EdgeInsets.all(15), // Adjust padding as needed
                          ),
                          obscureText: _obscureText,
                          controller: passwordTextController,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  FirebaseAuth.instance.signOut();
                } on FirebaseException catch (e) {
                  log(e.toString());
                }

                log("Username: ${emailTextController.text} -- password: ${passwordTextController.text}");
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                width: width,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isAllFilled
                      ? const Color(0xFFEB6440)
                      : const Color(0xFFD6E4E5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  maxLines: 1,
                  "Login",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isAllFilled ? Colors.white : Colors.grey,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignUpScreen()),
                );
              },
              child: const Text(
                "Don't have an account? Sign up now",
                style: TextStyle(
                    color: Color(0xFF267BDE),
                    fontWeight: FontWeight.w700,
                    fontSize: 16),
              ),
            )
          ],
        ),
      )),
    );
  }
}
