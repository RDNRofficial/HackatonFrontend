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

  bool shield = false;

  double speed = 7;
  double shootCooldown = 0;
  double newAngle = 0;
  double health = 100;
  double immunityCooldown = -1;
  double shieldCooldown = -1;

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
    if (this.immunityCooldown > 0) {
      this.immunityCooldown -= t;
    }
    if (this.shieldCooldown > 0) {
      this.shieldCooldown -= t;
    } else {
      this.shield = false;
    }
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
    if (shield) {
      d /= 2;
    }
    if (this.immunityCooldown <= 0) {
      if (this.health - d <= 0) {
        game.over = true;
      } else {
        this.health -= d;
      }
    }
  }

  void heal(double d) {
    this.health += d;
  }

  void shoot() {
    if (shootCooldown <= 0) {
      Spray spray = new Spray(game, angle, movePointer);
      game.add(spray);
      game.sprays.add(spray);
      shootCooldown = 0.5;
    }
  }
}
