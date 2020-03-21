import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatonfrontend/game/DrawEnemy.dart';
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
      home: MyHomePage(title: 'Das ist ein Text'),
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
      "virus.png"
    ]);

    // Alle benötigten Audios werden vorgeladen.
    Flame.audio.loadAll(<String>[]);

    GameEngine game = GameEngine();
    runApp(game.widget);

    TapGestureRecognizer tapper = TapGestureRecognizer();
    tapper.onTapDown = game.onTapDown;
    flameUtil.addGestureRecognizer(tapper);
  }

  startQuiz() {
    runApp(Quiz());
  }
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
          ],
        ),
      ),
    );
  }
}
