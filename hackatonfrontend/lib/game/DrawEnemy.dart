import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackatonfrontend/game/Draw.dart';

class DrawEnemy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Draw(),
    );
  }
}