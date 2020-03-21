import 'package:flame/box2d/box2d_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:hackatonfrontend/game/Player.dart';
import 'package:hackatonfrontend/game/level/Level.dart';
import "dart:developer" as console;

class GameWorld extends Box2DComponent {
  Player player;

  Size screenSize;

  GameWorld() : super(scale: 2.0);

  void initializeWorld() {
    addAll(Level(this).bodies);
    add(player = Player(this));
  }

  @override
  void update(t) {
    super.update(t);
    cameraFollow(player, horizontal: 0, vertical: 0);
  }

  void handleTap(Offset position) {}

  void handleDragStart(DragStartDetails d) {
    player.handleDragStart(d);
  }

  void handleDragUpdate(DragUpdateDetails d) {
    player.handleDragUpdate(d);
  }

  void givePlayerSize(Size size) {
    this.player.screenSize = size;
  }
}
