import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/gestures.dart';
import 'package:flutter/gestures.dart';
import 'package:hackatonfrontend/game/Background.dart';
import 'package:hackatonfrontend/game/Enemy.dart';
import 'package:hackatonfrontend/game/Player.dart';
import 'package:hackatonfrontend/game/SpawnController.dart';
import 'package:hackatonfrontend/game/Spray.dart';
import 'package:hackatonfrontend/game/items/Gloves.dart';
import 'package:hackatonfrontend/game/items/Mask.dart';
import 'package:hackatonfrontend/game/items/Soap.dart';
import 'package:wakelock/wakelock.dart';
import "package:box2d_flame/box2d.dart";

class GameEngine extends BaseGame with PanDetector, HasWidgetsOverlay {
  static const num TILE_AMOUNT = 9;

  Background background;

  bool moving = false;
  bool over = false;

  double tileSize;

  List<Enemy> enemies;

  List<SpriteComponent> items;

  Player player;

  Size worldSize;

  SpawnController spawnController;

  List<Spray> sprays;

  Vector2 origin;
  Vector2 playerPos;

  //List<Wall> walls;

  GameEngine() {
    this.initialize();
  }

  void initialize() async {
    Wakelock.enable();

    this.resize(await Flame.util.initialDimensions());

    this.origin = Vector2(-size.width, -size.height);
    this.background = new Background(this);
    this.player = new Player(this);
    this.enemies = new List<Enemy>();
    this.sprays = new List<Spray>();
    this.items = new List<SpriteComponent>();
    this.spawnController = new SpawnController(this);
    this.playerPos = Vector2(player.toRect().center.dx + size.width,
        player.toRect().center.dy + size.height);
    add(this.background);
    add(this.player);
    add(this.spawnController);
  }

  void moveRelative(Vector2 pointer) {
    Vector2 movePointer = Vector2(pointer.x * -1, pointer.y * -1);
    this.background.addXY(movePointer.x, movePointer.y);
    this.enemies.forEach((e) => e.addXY(movePointer.x, movePointer.y));
    this.sprays.forEach((s) => s.addXY(movePointer.x, movePointer.y));
    for (SpriteComponent sc in items) {
      if (sc is Soap) {
        sc.addXY(movePointer.x, movePointer.y);
      }
      if (sc is Mask) {
        sc.addXY(movePointer.x, movePointer.y);
      }
      if (sc is Gloves) {
        sc.addXY(movePointer.x, movePointer.y);
      }
    }
  }

  void remove(Component c) {
    this.components.remove(c);
  }

  void resize(Size size) {
    super.resize(size);
    this.worldSize = Size(this.size.width * 3, this.size.height * 3);
    this.tileSize = size.width / TILE_AMOUNT;
    console.log(size.toString());
  }

  void onPanDown(DragDownDetails d) {}

  void onPanStart(DragStartDetails d) {
    this.player.move(d.globalPosition.dx, d.globalPosition.dy);
    this.moving = true;
  }

  void onPanUpdate(DragUpdateDetails d) {
    this.player.move(d.globalPosition.dx, d.globalPosition.dy);
    this.moving = true;
  }

  void onPanEnd(DragEndDetails d) {
    this.moving = false;
  }

  void onPanCancle() {
    this.moving = false;
  }

  void onTapUp(TapUpDetails d) {
    player.shoot();
  }
}
