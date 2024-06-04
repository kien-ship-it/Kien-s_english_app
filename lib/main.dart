import 'package:english_app/features/GeneralScreen.dart';
import 'package:english_app/features/Learn%20/Multiple%20Choice/MultipleChoice.dart';
import 'package:english_app/features/lesson/LessonScreen.dart';
import 'package:english_app/features/user/UserScreen.dart';
import 'package:english_app/services/auth.dart';
import 'package:english_app/features/home/home_screen.dart';
import 'package:english_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/authentication/login_screen.dart';
import 'features/lesson/IndividualLesson/ALessonScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // setup firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginScreen()
          : const GeneralScreen()
    );
  }
}

// FirebaseAuth.instance.currentUser == null
// ? const LoginScreen()
//     : const GeneralScreen()
