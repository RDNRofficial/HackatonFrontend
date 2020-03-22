import "dart:developer" as console;
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/main.dart';
import 'dart:ui' as ui;
import 'dart:async';
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

  Future<Size> calcutateImageSize(Image image) {
    Completer<Size> completer = Completer();
    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
          var myImage = image.image;
          Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
          completer.complete(size);
        },
      ),
    );
    return completer.future;
  }


  Widget getAnswerWidget(BuildContext context, Answer a) {
    Image image = Image.network("http://bitschi.hopto.org:8000" + a.before);
    Future<Size> size = this.calcutateImageSize(image);
    size.then((Size s) => console.log(s.width.toString()));
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return FutureBuilder<Size> (

    future: size,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Positioned(
                left: width * a.y,
                top: height * a.y,
                width: 200,
                height: 200,
                child: GestureDetector(
                    onTap: () {
                      console.log("Test");
                      setState(() {
                        a.clicked = true;
                      });
                    },
                    child: Image(image: image.image)
                )
            );
          } else if (snapshot.hasError) {
            return Text("Fehler: ${snapshot.error}");
          }
          return CircularProgressIndicator();
        }
    );

  }

  List<Widget> getMenuWidget(QuestionAnswer qa, List<QuestionAnswer> list) {
    FloatingActionButton help = FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.live_help),
    );
    bool finished = qa.answers.map((a) => !a.solution || a.clicked).fold(true, (a, b) => a&&b);
    return !finished ? [help] : <Widget>[
      help,
      FloatingActionButton(
        onPressed: () { this.nextQuestion(list); },
        backgroundColor: Colors.green,
        child: Icon(Icons.navigate_next),
      )
    ];
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
          floatingActionButtonLocation:  FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: this.getMenuWidget(qa, list),
            ),
          ),

          body: new Column(
            children: <Widget>[
              SizedBox(height: 50),
              Center(child: new Text(qa.question.question, textAlign: TextAlign.center, style: TextStyle(fontSize: 25),)),
            ]
          ),
        ),

      ] + qa.answers.map((Answer a) => this.getAnswerWidget(context, a)).toList(),
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
          return Text("Fehler: ${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
