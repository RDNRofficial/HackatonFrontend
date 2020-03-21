import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:hackatonfrontend/game/GameWorld.dart';

class GameEngine extends Game with PanDetector {
  final GameWorld gameWorld = GameWorld();

  GameEngine() {
    gameWorld.initializeWorld();
  }

  @override
  void render(Canvas c) {
    gameWorld.render(c);
  }

  @override
  void update(double t) {
    gameWorld.update(t);
  }

  @override
  void resize(Size size) {
    gameWorld.resize(size);
    gameWorld.givePlayerSize(size);
    console.log(size.toString());
  }

  @override
  void onPanStart(DragStartDetails details) {
    gameWorld.handleDragStart(details);
  }

  @override
  void onPanUpdate(DragUpdateDetails details) {
    gameWorld.handleDragUpdate(details);
  }
}
