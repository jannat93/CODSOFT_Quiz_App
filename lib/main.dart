import 'package:flutter/material.dart';
import 'package:quiz_app/welcome_screen.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}
