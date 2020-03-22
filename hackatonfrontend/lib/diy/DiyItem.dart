import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackatonfrontend/model/DIY.dart';
import 'package:hackatonfrontend/model/DIYList.dart';
import 'package:hackatonfrontend/model/Explanation.dart';



class DiyItem extends StatelessWidget {

  final DIY diy;

  DiyItem({Key key, @required this.diy}) : super(key: key);

  int num = 1;

  List<Text> getContent() {
    return this.diy.lists.map((l) => [
      Text(l.title,
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 25,
            color: Colors.green,
            fontWeight: FontWeight.bold
        ),
      )
    ] + l.steps.map((t) =>
        Text((l.diyType == "Execution" ? (num++).toString() + ". " : "")+ t.text,
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.left,
            )
    ).toList()).fold([], (a, b) => a+b);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.diy.diyManual.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin:  const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: this.getContent(),
          ),
        ),
      )
    );
  }
}