import 'dart:developer';

import 'package:english_app/Widgets/MyToast.dart';
import 'package:english_app/services/auth.dart';
import 'package:english_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPassTextController = TextEditingController();
  bool isAllFilled = false;
  bool _obscureTextPass = true;
  bool _obscureTextConfirmPass = true;


  @override
  void initState() {
    super.initState();
    emailTextController.addListener(updateButtonState);
    fullNameTextController.addListener(updateButtonState);
    passwordTextController.addListener(updateButtonState);
    confirmPassTextController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      isAllFilled = emailTextController.text.isNotEmpty &&
          fullNameTextController.text.isNotEmpty &&
          passwordTextController.text.isNotEmpty &&
          confirmPassTextController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5F5),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: height/11,),
              Text(
                "Sign Up",
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
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      )
                    ]),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Email",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                      controller: emailTextController,
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    TextField(
                      decoration: const InputDecoration(
                        hintText: "Full Name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(15),
                      ),
                      controller: fullNameTextController,
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Password",
                              border: InputBorder
                                  .none, // Remove default underline border
                              contentPadding: EdgeInsets.all(
                                  15), // Adjust padding as needed
                            ),
                            obscureText: _obscureTextPass,
                            controller: passwordTextController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureTextPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextPass = !_obscureTextPass;
                            });
                          },
                        )
                      ],
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Confirm Password",
                              border: InputBorder
                                  .none, // Remove default underline border
                              contentPadding: EdgeInsets.all(
                                  15), // Adjust padding as needed
                            ),
                            obscureText: _obscureTextConfirmPass,
                            controller: confirmPassTextController,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureTextConfirmPass
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureTextConfirmPass =
                                  !_obscureTextConfirmPass;
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
                onTap: () {
                  if (checkValidate()) {
                    Auth()
                        .signUpWithEmailAndPassword(
                            email: emailTextController.text,
                            password: passwordTextController.text)
                        .then((value) {
                      if (mounted) {
                        showToast("Sign Up Successful");
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      }
                    });
                  }
                },
                child: AnimatedContainer(
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
                          offset:
                              const Offset(0, 1), // changes position of shadow
                        )
                      ]),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isAllFilled ? Colors.white : Colors.grey),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Have an account? Log in now",
                  style: TextStyle(
                      color: Color(0xFF267BDE),
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool checkValidate() {
    var result = true;
    if (!isAllFilled) {
      showToast("Please fill all fields");
      result = false;
    }

    // check email by regex
    else if (!RegExp(r"^^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(emailTextController.text)) {
      showToast("Please enter a valid email");
      result = false;
    }

    // check password by regex that have at least 8 characters, at least one uppercase letter, at least one lowercase letter, and at least one number
    else if (!RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$")
        .hasMatch(passwordTextController.text)) {
      showToast("Please enter a valid password");
      result = false;
    }

    // check confirm password
    else if (passwordTextController.text != confirmPassTextController.text) {
      showToast("Password and confirm password does not match");
      result = false;
    }

    return result;
  }
}
