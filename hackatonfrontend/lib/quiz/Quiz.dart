import "dart:developer" as console;
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/main.dart';
import 'package:hackatonfrontend/model/QuestionAnswer.dart';
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

  Future<List<QuestionAnswer>> future;


  int questionNumber = 0;

  void nextQuestion(List<QuestionAnswer> questions) {
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
    this.future =  Rest.instance.fetchQuestionAnswerList();
  }

  Widget getAnswerWidget(BuildContext context, Answer a) {
    int width = MediaQuery.of(context).size.width.toInt();
    double y = 200;
    return Positioned(
        left: 0,
        top: 0,
        width: 50,
        height: 50,
        child: GestureDetector(
          onTap: () => console.log("Test"),
          child: Image(
              image: Image.network(a.before).image,
              width: 50,
              height: 50,
          )
        )
    );
  }

    Widget getQuestionWidget(BuildContext context, QuestionAnswer qa, List<QuestionAnswer> list) {
    Image background = Image.network(qa.question.background);
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent[100],
            image: DecorationImage(
              image: background.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          floatingActionButton: new FloatingActionButton(
            onPressed: () => this.nextQuestion(list),
            child: Icon(Icons.help_outline),
          ),
          body: new Column(
            children: <Widget>[
              SizedBox(height: 50),
              Center(child: new Text(qa.question.question, textAlign: TextAlign.center, style: TextStyle(fontSize: 30),)),
              new Text(qa.answers.length.toString()),
            ]
          ),
        ),
      ] + qa.answers.map((Answer a) => Image(
        image: Image.network("http://bitschi.hopto.org:8000" + a.before).image,
        width: 200,
        height: 200,
      )).toList()
      /*qa.answers.map((Answer a) => this.getAnswerWidget(context, a)).toList() */,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<QuestionAnswer>>(
      future: this.future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return this.getQuestionWidget(context, snapshot.data[this.questionNumber], snapshot.data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
