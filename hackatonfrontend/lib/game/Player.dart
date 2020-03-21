import 'dart:ui';
import "dart:math" as math;

import 'package:flame/box2d/box2d_component.dart';
import "package:box2d_flame/box2d.dart";
import 'package:flame/sprite.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:hackatonfrontend/game/GameEngine.dart';
import 'package:flutter/painting.dart';
import 'package:hackatonfrontend/game/utils.dart';
import "dart:developer" as console;

class Player extends BodyComponent {
  static const num PLAYER_RADIUS = 8.0;

  ImagesLoader images = new ImagesLoader();

  bool isDead;
  bool idle;
  bool forward;

  double angle = 0;
  double health;
  double shootCooldown;

  Size screenSize;

  Player(box2d) : super(box2d) {
    this.health = 100.0;
    _loadImages();
    _createBody();
  }

  void _loadImages() {
    images.load("player-0", "player.png");
  }

  @override
  void renderCircle(Canvas canvas, Offset center, double radius) {
    if (images.isLoading) {
      return;
    }

    var image = images.get("player-0");

    double r = math.sqrt(this.screenSize.width * this.screenSize.width +
            this.screenSize.height * this.screenSize.height) /
        2;
    double alpha = math.atan(this.screenSize.height / this.screenSize.width);
    double beta = alpha + angle;
    double shiftY = r * math.sin(beta);
    double shiftX = r * math.cos(beta);
    double translateX = this.screenSize.width / 2 - shiftX;
    double translateY = this.screenSize.height / 2 - shiftY;
    canvas.translate(translateX, translateY);
    canvas.rotate(angle);

    paintImage(
        canvas: canvas,
        image: image,
        rect: new Rect.fromCircle(center: center, radius: radius),
        flipHorizontally: !this.forward,
        fit: BoxFit.contain);
  }

  @override
  void update(double t) {
    this.idle =
        body.linearVelocity.x.abs() < 0.1 && body.linearVelocity.y.abs() < 0.1;
    this.forward = body.linearVelocity.x >= 0.0;
  }

  void _createBody() {
    final shape = new CircleShape();
    shape.radius = Player.PLAYER_RADIUS;
    shape.p.x = 0.0;

    final activeFixtureDef = new FixtureDef();
    activeFixtureDef.shape = shape;
    activeFixtureDef.restitution = 1;
    activeFixtureDef.density = 0.05;
    activeFixtureDef.friction = 1;
    FixtureDef fixtureDef = activeFixtureDef;
    final activeBodyDef = new BodyDef();
    activeBodyDef.linearVelocity = new Vector2(0.0, 0.0);
    activeBodyDef.position = new Vector2(0.0, 15.0);
    activeBodyDef.type = BodyType.DYNAMIC;
    activeBodyDef.bullet = true;
    activeBodyDef.linearDamping = 50;
    BodyDef bodyDef = activeBodyDef;

    this.body = world.createBody(bodyDef)
      ..createFixtureFromFixtureDef(fixtureDef);
  }

  void handleDragStart(widgets.DragStartDetails d) {
    this.move(d.globalPosition.dx, d.globalPosition.dy);
  }

  void handleDragUpdate(widgets.DragUpdateDetails d) {
    this.move(d.globalPosition.dx, d.globalPosition.dy);
  }

  void move(double x, double y) {
    Vector2 orient = new Vector2(0, -10);
    Vector2 fingerpos = new Vector2(
        x - this.screenSize.width / 2, y - this.screenSize.height / 2);
    this.angle = orient.angleToSigned(fingerpos);
    if (this.angle < 0) {
      this.angle = 2 * math.pi + this.angle;
    }
    impulse(Offset(fingerpos.x / (this.screenSize.width / 2),
        fingerpos.y / (this.screenSize.height / 2)));
  }

  void impulse(Offset velocity) {
    Vector2 force = new Vector2(velocity.dx, -velocity.dy)..scale(100000.0);
    body.applyLinearImpulse(force, center, true);
  }
}
