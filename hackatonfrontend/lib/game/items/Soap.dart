import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";

class Soap extends SpriteComponent {
  final GameEngine game;

  Vector2 cameraPointer = Vector2(0, 0);

  Soap(this.game, double x, double y)
      : super.fromSprite(game.tileSize, game.tileSize, new Sprite("soap.png")) {
    this.x = x;
    this.y = y;
  }

  void update(double t) {
    if (game.moving) {
      this.x += this.cameraPointer.x * t;
      this.y += this.cameraPointer.y * t;
    }

    if (this.toRect().contains(game.player.toRect().center)) {
      game.player.heal(10);
      game.items.remove(this);
      game.remove(this);
    }
  }

  void addXY(double x, double y) {
    this.cameraPointer = Vector2(x, y);
  }
}
