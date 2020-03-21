import "dart:developer" as console;
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/quiz/CurvePainter.dart';
import 'package:hackatonfrontend/model/Question.dart';
import 'package:hackatonfrontend/services/Rest.dart';


class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Corona Quiz",
        home: Container(
            color: Colors.white, child: CustomPaint(painter: CurvePainter())));
  }
}

class QuizPage extends StatefulWidget {
  QuizPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  Future<List<Question>> futureQuestion;

  @override
  void initState() {
    super.initState();
    this.futureQuestion =  Rest.instance.fetchQuestionList();
  }

  @override
  Widget build(BuildContext context) {


    return Container();
  }
}
