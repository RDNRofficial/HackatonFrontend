import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import "package:box2d_flame/box2d.dart";

class Mask extends SpriteComponent {
  final GameEngine game;

  Vector2 cameraPointer = Vector2(0, 0);

  Mask(this.game, double x, double y)
      : super.fromSprite(game.tileSize, game.tileSize, new Sprite("mask.png")) {
    this.x = x;
    this.y = y;
  }

  void update(double t) {
    if (game.moving) {
      this.x += this.cameraPointer.x * t;
      this.y += this.cameraPointer.y * t;
    }

    if (this.toRect().contains(game.player.toRect().center)) {
      game.player.immunityCooldown = 5;
      game.items.remove(this);
      game.remove(this);
    }
  }

  void addXY(double x, double y) {
    this.cameraPointer = Vector2(x, y);
  }
}
