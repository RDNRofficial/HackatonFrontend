import 'package:hackatonfrontend/model/DIYManual.dart';
import 'package:hackatonfrontend/model/Explanation.dart';


class DIY{
  DIYManual diyManual;
  List<Explanation> materials;
  List<Explanation> explanations;
  List<Explanation> executions;

  factory DIY.fromJson(Map<String, dynamic> json) {
    List jsonMaterials = json['items'];
    List jsonExplanations = json['explanations'];
    List jsonExecution = json['gameplay'];
    return DIY(
      diyManual: DIYManual.fromJson(json),
      materials: jsonMaterials.map((a) => Explanation.fromJson(a)).toList(),
      explanations: jsonExplanations.map((a) => Explanation.fromJson(a)).toList(),
      executions: jsonExecution.map((a) => Explanation.fromJson(a)).toList(),
    );
  }

  DIY({this.diyManual, this.materials, this.explanations, this.executions});
}