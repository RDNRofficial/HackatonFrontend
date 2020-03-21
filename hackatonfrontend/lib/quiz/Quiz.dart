import "dart:developer" as console;
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/main.dart';
import 'package:hackatonfrontend/quiz/CurvePainter.dart';
import 'package:hackatonfrontend/model/Question.dart';
import 'package:hackatonfrontend/model/Answer.dart';
import 'package:hackatonfrontend/services/Rest.dart';

class Quiz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "Corona Quiz", home: QuizPage());
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
  Future<List<Answer>> futureAnswer;

  int questionNumber = 0;

  void nextQuestion(List<Question> questions) {
    this.setState(
      () {
        if(questions.length > this.questionNumber + 1) {
          this.questionNumber++;
        }else {
          Router.instance.startGame();
        }
      });
  }

  @override
  void initState() {
    super.initState();
    this.futureAnswer = Rest.instance.fetchAnswerList();
    this.futureQuestion =  Rest.instance.fetchQuestionList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: this.futureQuestion,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Scaffold(
                floatingActionButton: new FloatingActionButton(onPressed: () => this.nextQuestion(snapshot.data), child: Icon(Icons.help_outline),),
                backgroundColor: Colors.grey[900],
                body: new Column(
                    children: <Widget>[
                      SizedBox(height: 50),
                      new Text(snapshot.data[this.questionNumber].question, style: TextStyle(color: Colors.grey[100])),
                    ])
            );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
