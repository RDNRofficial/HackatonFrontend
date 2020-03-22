import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hackatonfrontend/diy/DiyItem.dart';
import 'package:hackatonfrontend/model/DIY.dart';
import 'package:hackatonfrontend/services/Rest.dart';



class Diy extends StatelessWidget {
  Future<List<DIY>> future = Rest.instance.fetchDIY();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: FutureBuilder<List<DIY>>(
        future: this.future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
                children: snapshot.data.map((DIY d) => ListTile(
                  title: Text(d.diyManual.title),
                  leading: Image.network(d.diyManual.titleImage),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiyItem(diy: d),
                      ),
                    );
                  },
                )).toList()
            );
          } else if (snapshot.hasError) {
            return Text("Fehler: ${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}


