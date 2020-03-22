import 'package:hackatonfrontend/model/Explanation.dart';

class DIYList {
  String diyType;
  String title;
  int manual;
  List<Explanation> steps;

  factory DIYList.fromJson(Map<String, dynamic> json) {
    List jsonSteps = json['steps'];
    return DIYList(
      diyType: json['diyType'],
      title: json['title'],
      steps: jsonSteps.map((a) => Explanation.fromJson(a)).toList(),
    );
  }

  DIYList({this.diyType, this.title, this.manual, this.steps});
}