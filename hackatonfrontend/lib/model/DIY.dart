import 'package:hackatonfrontend/model/DIYList.dart';
import 'package:hackatonfrontend/model/DIYManual.dart';
import 'package:hackatonfrontend/model/Explanation.dart';


class DIY{
  DIYManual diyManual;
  List<DIYList> lists;

  factory DIY.fromJson(Map<String, dynamic> json) {
    List jsonLists = json['lists'];
    return DIY(
      diyManual: DIYManual.fromJson(json),
      lists: jsonLists.map((a) => DIYList.fromJson(a)).toList(),
    );
  }

  DIY({this.diyManual, this.lists});
}