import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";

class Spray extends SpriteComponent {
  final GameEngine game;

  Vector2 cameraPointer = Vector2(0, 0);
  Vector2 movePointer;

  double speed = 250;
  double reach = 1;

  Spray(this.game, double angle, Vector2 movePointer)
      : super.fromSprite(
            game.tileSize, game.tileSize, new Sprite("spray.png")) {
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
      game.remove(this);
      reach = 1;
    } else {
      this.x += movePointer.x * t * speed;
      this.y += movePointer.y * t * speed;
      reach -= t;
    }

    List<Component> toRemove = new List<Component>();
    game.enemies.forEach((SpriteComponent c) {
      if (this.toRect().contains(c.toRect().center)) {
        toRemove.add(c);
        toRemove.add(this);
      }
    });
    toRemove.forEach((f) => game.remove(f));
  }

  void addXY(double x, double y) {
    this.cameraPointer = Vector2(x, y);
  }
}
