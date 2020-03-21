import 'dart:ui';

import 'package:flame/sprite.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';

/*class Enemy {
  final double fallingSpeed = 10.0;

  final GameEngine game;

  bool isDead;
  bool isOffscreen;

  double get speed => this.game.tileSize * 3;

  Offset targetLocation;

  Rect enemyRect;

  Sprite enemySprite;

  Enemy(this.game, double x, double y) {
    this.enemyRect =
        Rect.fromLTWH(x, y, this.game.tileSize, this.game.tileSize);
    this.enemySprite = Sprite("virus.png");
    this.isDead = false;
    this.isOffscreen = false;
    this.setTargetLocation();
  }

  void render(Canvas c) {
    enemySprite.renderRect(c, this.enemyRect);
  }

  void update(double t) {
    if (isDead) {
      this.enemyRect = this
          .enemyRect
          .translate(0, this.game.tileSize * this.fallingSpeed * t);
      if (this.enemyRect.top > this.game.screenSize.height) {
        isOffscreen = true;
      }
    } else {
      double stepDistance = this.speed * t;
      Offset toTarget = targetLocation - Offset(enemyRect.left, enemyRect.top);
      if (stepDistance < toTarget.distance) {
        Offset stepToTarget =
            Offset.fromDirection(toTarget.direction, stepDistance);
        this.enemyRect = this.enemyRect.shift(stepToTarget);
      } else {
        this.enemyRect = this.enemyRect.shift(toTarget);
        this.setTargetLocation();
      }
    }
  }

  void setTargetLocation() {
    double x = this.game.rnd.nextDouble() *
        (this.game.screenSize.width - this.game.tileSize);
    double y = this.game.rnd.nextDouble() *
        (this.game.screenSize.height - this.game.tileSize);
    this.targetLocation = Offset(x, y);
  }

  void onTapDown() {}
}*/
