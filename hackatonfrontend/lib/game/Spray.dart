import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/Enemy.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";
import "dart:developer" as console;

class Spray extends SpriteComponent {
  final GameEngine game;

  Vector2 cameraPointer = Vector2(0, 0);
  Vector2 movePointer;

  double speed = 8;
  double reach = 1;

  Spray(this.game, double angle, Vector2 movePointer)
      : super.fromSprite(
            game.tileSize, game.tileSize, new Sprite("spray.png")) {
    this.angle = 0;
    this.anchor = Anchor.center;
    this.movePointer = movePointer;
    this.movePointer.normalize();
    this.x = game.size.width / 2;
    this.y = game.size.height / 2;
    this.angle = angle;
  }

  void update(double t) {
    if (game.moving) {
      this.x += this.cameraPointer.x * t;
      this.y += this.cameraPointer.y * t;
    }

    if (reach <= 0) {
      game.sprays.remove(this);
      game.remove(this);
    } else {
      this.x += movePointer.x * t * speed * game.tileSize;
      this.y += movePointer.y * t * speed * game.tileSize;
      reach -= t;
    }

    bool remove = false;
    Enemy eRemove;
    int i = 0;
    for (Enemy e in game.enemies) {
      console.log("ENEMY $i AT " + e.toRect().center.toString());
      if (this.toRect().contains(e.toRect().center)) {
        console.log("HIT ENEMY $i");
        remove = true;
        eRemove = e;
        break;
      }
      i++;
    }
    if (remove) {
      game.sprays.remove(this);
      game.remove(this);
    }
    if (eRemove != null) {
      game.enemies.remove(eRemove);
      game.remove(eRemove);
    }
  }

  void addXY(double x, double y) {
    this.cameraPointer = Vector2(x, y);
  }
}
