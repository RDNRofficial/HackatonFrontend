import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackatonfrontend/services/Rest.dart';
import 'package:hackatonfrontend/model/DIY.dart';
import 'package:hackatonfrontend/model/DIYManual.dart';
import 'package:hackatonfrontend/model/Explanation.dart';


class ManualSite extends StatefulWidget {
  @override
  _DIYManualState createState() => new _DIYManualState();
}

class _DIYManualState extends State<ManualSite> {
  // for Schleife über eine liste = ein Step? Jedes Element der Liste ein step
  List<Step> steps = [
    Step(
      title: const Text('Title'),
      isActive: true,
      state: StepState.complete,
      content: Column(
        children: <Widget>[
          Image(image: null)
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text('Create an account'),
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Stepper(
              steps: steps,
            ),
          ),
        ]));
    }
  }