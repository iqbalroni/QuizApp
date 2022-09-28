import 'package:flutter/material.dart';
import 'package:listapi/offline/game.dart';
import 'package:listapi/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Screen(),
      title: "QuizDemo",
    );
  }
}
