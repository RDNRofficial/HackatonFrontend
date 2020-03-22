import 'dart:math';
import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/components/component.dart';
import 'package:hackatonfrontend/game/Enemy.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';

class SpawnController extends Component {
  final GameEngine game;

  Random rnd = new Random();

  double spawnCountdown = 0;

  SpawnController(this.game);

  void update(double t) {
    if (spawnCountdown <= 0) {
      double nx = rnd.nextDouble() * (game.worldSize.width - game.tileSize) +
          game.origin.x;
      double ny = rnd.nextDouble() * (game.worldSize.height - game.tileSize) +
          game.origin.y;
      Enemy insert = new Enemy(game, nx, ny);
      game.add(insert);
      game.enemies.add(insert);
      spawnCountdown = 5.0;
    } else {
      spawnCountdown -= t;
    }
  }

  @override
  void render(Canvas c) {}
}
