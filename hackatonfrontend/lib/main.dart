import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatonfrontend/diy/DiyPage.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import 'package:hackatonfrontend/model/Question.dart';
import 'package:hackatonfrontend/quiz/Quiz.dart';

import 'services/Rest.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Corona und was jetzt?'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Router {
  static final Router instance = Router.internal();
  factory Router() => instance;

  Router.internal() {}

  // Übergang ins Spiel
  startGame() async {
    //runApp(DrawEnemy());

    WidgetsFlutterBinding.ensureInitialized();

    Util flameUtil = new Util();
    await flameUtil.fullScreen();
    await flameUtil.setOrientation(DeviceOrientation.portraitUp);

    // Alle benötigten Bilder werden vorgeladen.
    Flame.images.loadAll(<String>[
      "virus.png",
      "player.gif",
      "background.png",
      "spray.gif",
      "mask.png",
      "gloves.png",
      "soap.png"
    ]);

    // Alle benötigten Audios werden vorgeladen.
    Flame.audio.loadAll(<String>[]);

    GameEngine game = GameEngine();
    runApp(game.widget);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    //tapper.onTapDown = game.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  }

  startQuiz() {
    runApp(Quiz());
  }

  startDIY(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Diy(),
      ),
    );
    //runApp(Diy());
  }
}

class _MyHomePageState extends State<MyHomePage> {
  List<Point<double>> virusPoints = [
    new Point<double>(40, 400),
    new Point<double>(80, 200),
    new Point<double>(128, 600),
    new Point<double>(170, 200),
    new Point<double>(200, 500),
    new Point<double>(300, 300),
  ];

  Widget virusWidget(double x, double y) {
    return Positioned(
        left: x,
        top: y,
        width: 40,
        height: 40,
        child: Image.asset("assets/images/virus.png"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Stack(
          children: <Widget>[
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: Router.instance.startGame,
                        child: Text("Game"),
                        color: Colors.lightGreen,
                      ),
                      RaisedButton(
                        onPressed: Router.instance.startQuiz,
                        child: Text("Quiz"),
                        color: Colors.lightGreen,
                      ),
                      RaisedButton(
                          onPressed: () => Router.instance.startDIY(context),
                          child: Text("DIY"),
                          color: Colors.lightGreen),
                    ],
                  ),
                ),
              ] +
              this.virusPoints.map((p) => this.virusWidget(p.x, p.y)).toList(),
        ));
  }
}
