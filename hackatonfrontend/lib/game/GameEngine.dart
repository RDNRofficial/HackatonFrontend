import 'dart:math';
import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import "package:hackatonfrontend/game/Enemy.dart";

class GameEngine extends Game {
  final int tileAmount = 7; // Anzahl der Tiles auf der Breite.

  double spawnCountdown;
  double spawnCounter;
  double tileSize; // Größe eines Tiles abhängig von der Screen Breite.

  List<Enemy> enemies;

  Random rnd;

  Size screenSize;

  // Konstruktor: initialize wird extra aufgerufen, um asynchrone Initialisierung zu erlauben. Asynchron geht nicht in Konstruktoren.
  GameEngine() {
    this.initialize();
  }

  void initialize() async {
    this.resize(await Flame.util
        .initialDimensions()); // Await, damit eventuelle 0x0 Auflösungen verhindert werden.
    this.rnd = Random();
    this.enemies = List<Enemy>();
    this.spawnEnemy();
    this.spawnCountdown = 5.0;
    this.spawnCounter = this.spawnCountdown;
  }

  // In der render Funktion wird alles graphishe dargestellt. Wird ca. 60 mal in der Sekunde aufgerufen, je nach Geräteleistung.
  void render(Canvas c) {
    Rect bgRect =
        Rect.fromLTWH(0, 0, this.screenSize.width, this.screenSize.height);
    Paint bgPaint = Paint();
    bgPaint.color = Color(0xff576574);
    c.drawRect(bgRect, bgPaint);
    this.enemies.forEach((e) => e.render(c));
  }

  // In der update Funktion wird alles berechnet, was Spielrelevant ist. double t ist die Zeitdifferenz, um unabhängig von den Frames eine gleichmäßige Berechnung zu ermöglichen.
  void update(double t) {
    this.enemies.forEach((Enemy e) {
      if (e.isOffscreen) {
        this.enemies.remove(e);
      } else {
        e.update(t);
      }
    });
    if (this.spawnCounter - t <= 0) {
      this.spawnEnemy();
      this.spawnCounter = this.spawnCountdown;
    } else {
      this.spawnCounter -= t;
    }
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    if (!isHandled) {
      enemies.forEach((Enemy e) {
        if (e.enemyRect.contains(d.globalPosition)) {
          e.isDead = true;
          isHandled = true;
        }
      });
    }
  }

  void spawnEnemy() {
    double x = rnd.nextDouble() * (this.screenSize.width - tileSize);
    double y = rnd.nextDouble() * (this.screenSize.height - tileSize);
    this.enemies.add(Enemy(this, x, y));
  }

  //
  void resize(Size size) {
    this.screenSize = size;
    this.tileSize = size.width / this.tileAmount;
  }
}
