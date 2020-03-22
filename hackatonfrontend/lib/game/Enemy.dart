import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart" as b;

class Enemy extends SpriteComponent {
  final GameEngine game;

  double speed = 70;

  b.Vector2 cameraPointer = b.Vector2(0, 0);

  Enemy(this.game, double spawnX, double spawnY)
      : super.fromSprite(
            game.tileSize, game.tileSize, new Sprite("virus.png")) {
    this.x = spawnX;
    this.y = spawnY;
    this.anchor = Anchor.center;
  }

  void update(double t) {
    if (game.moving) {
      this.x += this.cameraPointer.x * t;
      this.y += this.cameraPointer.y * t;
    }

    b.Vector2 playerPos = b.Vector2(
        game.player.toRect().center.dx, game.player.toRect().center.dy);
    b.Vector2 direction =
        b.Vector2(this.toRect().center.dx, this.toRect().center.dy);
    playerPos.sub(direction);
    playerPos.normalize();
    this.x += playerPos.x * this.speed * t;
    this.y += playerPos.y * this.speed * t;
  }

  void addXY(double x, double y) {
    this.cameraPointer = b.Vector2(x, y);
  }
}
