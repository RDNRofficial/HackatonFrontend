import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";

class Background extends SpriteComponent {
  final GameEngine game;

  Vector2 cameraPointer = Vector2(0, 0);

  Background(this.game)
      : super.fromSprite(game.worldSize.width, game.worldSize.height,
            new Sprite("background.png")) {
    this.x = -this.game.size.width;
    this.y = -this.game.size.height;
  }

  void update(double t) {
    if (game.moving) {
      this.x += this.cameraPointer.x * t;
      this.y += this.cameraPointer.y * t;
      game.playerPos.add(Vector2(
          -1 * this.cameraPointer.x * t, -1 * this.cameraPointer.y * t));
      game.origin = Vector2(this.x, this.y);
    }
  }

  void addXY(double x, double y) {
    this.cameraPointer = Vector2(x, y);
  }
}
