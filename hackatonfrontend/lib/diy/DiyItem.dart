import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackatonfrontend/model/DIY.dart';
import 'package:hackatonfrontend/model/DIYList.dart';
import 'package:hackatonfrontend/model/Explanation.dart';



class DiyItem extends StatelessWidget {

  final DIY diy;

  DiyItem({Key key, @required this.diy}) : super(key: key);

  int num = 1;

  List<Container> getContent() {
    return this.diy.lists.map((l) => [
      Container(
        margin: const EdgeInsets.only(top: 20.0, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Text(
            l.title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 25,
                color: Colors.green,
                fontWeight: FontWeight.bold
            ),
          ),
          Divider(
            color: Colors.green,
          )
        ],),
      )
    ] + l.steps.map((t) =>
        Container(
          margin: const EdgeInsets.only(left: 20.0, bottom: 6),
          child: Text(
            (l.diyType == "Execution" ? (num++).toString() + ". " : "")+ t.text,
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
        ),)
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: this.getContent(),
          ),
        ),
      )
    );
  }
}