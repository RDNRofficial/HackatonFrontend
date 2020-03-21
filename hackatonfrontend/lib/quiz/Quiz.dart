import "dart:developer" as console;
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/quiz/CurvePainter.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    this.initialize();

    return MaterialApp(
        title: "Corona Quiz",
        home: Container(
            color: Colors.white, child: CustomPaint(painter: CurvePainter())));
  }

  void initialize() {}
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
