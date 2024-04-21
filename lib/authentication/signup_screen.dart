import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController confirmPassTextController = TextEditingController();
  TextEditingController fullNameTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up Screen",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailTextController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Password"),
                obscureText: true,
                controller: passwordTextController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Confirm Your Password"),
                obscureText: true,
                controller: confirmPassTextController,
              ),
              TextField(
                decoration: InputDecoration(hintText: "Full Name"),
                controller: fullNameTextController,
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  log("Here!!!!!!");
                  log("Email: ${emailTextController.text}");
                  log("Password, ${passwordTextController.text}");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.teal,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Have an account? Log in now"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
