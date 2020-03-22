import 'dart:math';
import 'dart:ui';
import "dart:developer" as console;

import 'package:flame/components/component.dart';
import 'package:hackatonfrontend/game/Enemy.dart';
import 'package:hackatonfrontend/game/GameEngine.dart';
import 'package:hackatonfrontend/game/items/Gloves.dart';
import 'package:hackatonfrontend/game/items/Mask.dart';
import 'package:hackatonfrontend/game/items/Soap.dart';

class SpawnController extends Component {
  final GameEngine game;

  Random rnd = new Random();

  double spawnCountdown = 0;
  double maxCountdown = 5;

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
      if (maxCountdown > 0.25) {
        maxCountdown -= 0.1;
      }
      spawnCountdown = maxCountdown;
    } else {
      spawnCountdown -= t;
    }
  }

  void spawnItem(double x, double y) {
    int next = rnd.nextInt(3);
    if (next == 0) {
      int item = rnd.nextInt(3);
      switch (item) {
        case 0:
          Gloves toInsert = new Gloves(game, x, y);
          game.add(toInsert);
          game.items.add(toInsert);
          break;
        case 1:
          Mask toInsert = new Mask(game, x, y);
          game.add(toInsert);
          game.items.add(toInsert);
          break;
        case 2:
          Soap toInsert = new Soap(game, x, y);
          game.add(toInsert);
          game.items.add(toInsert);
          break;
      }
    }
  }

  @override
  void render(Canvas c) {}
}
