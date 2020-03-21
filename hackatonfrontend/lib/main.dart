import 'package:flame/flame.dart';
import 'package:flame/util.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hackatonfrontend/game/DrawEnemy.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
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

class _MyHomePageState extends State<MyHomePage> {

  // Übergang ins Spiel
  void _startGame() async {
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

  void _startQuiz() {
    runApp(Quiz());
  }


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
              onPressed: this._startGame,
              child: Text("Game"),
              color: Colors.lightGreen,
            ),
            RaisedButton(
              onPressed: this._startQuiz,
              child: Text("Quiz"),
              color: Colors.lightGreen,
            ),
          ],
        ),
      ),
    );
  }
}
