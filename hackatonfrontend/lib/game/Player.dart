import 'dart:ui';
import "dart:math" as math;
import "dart:developer" as console;

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";
import 'package:hackatonfrontend/game/Spray.dart';

class Player extends SpriteComponent {
  final GameEngine game;

  double speed = 7;
  double shootCooldown = 0;
  double newAngle = 0;
  double health = 100;

  Vector2 movePointer;

  Player(this.game)
      : super.fromSprite(
            game.tileSize, game.tileSize, new Sprite("player.png")) {
    this.x = this.game.size.width / 2;
    this.y = this.game.size.height / 2;
    this.anchor = Anchor.center;
    this.angle = 0;
    this.movePointer = Vector2(0, 0);
  }

  void update(double t) {
    shootCooldown -= t;
  }

  void move(double x, double y) {
    Vector2 relative =
        Vector2(x - this.game.size.width / 2, y - this.game.size.height / 2);
    Vector2 orient = Vector2(0, -1);
    relative.normalize();
    this.angle = orient.angleToSigned(relative);
    this.movePointer = Vector2(relative.x * this.speed * game.tileSize,
        relative.y * this.speed * game.tileSize);
    this.game.moveRelative(movePointer);
  }

  void damage(double d) {
    if (this.health - d <= 0) {
      // TODO
    } else {
      this.health -= d;
      console.log("PLAYER HEALTH: " + this.health.toString());
    }
  }

  void shoot() {
    if (shootCooldown <= 0) {
      console.log("shoot");
      Spray spray = new Spray(game, angle, movePointer);
      game.add(spray);
      game.sprays.add(spray);
      shootCooldown = 0.5;
    }
  }
}
