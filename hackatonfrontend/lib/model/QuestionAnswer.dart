
import 'package:hackatonfrontend/model/Answer.dart';
import 'package:hackatonfrontend/model/Question.dart';

class QuestionAnswer {
  Question question;
  List<Answer> answers;

  factory QuestionAnswer.fromJson(Map<String, dynamic> json) {
    List jsonAnswers = json["answers"];
    return QuestionAnswer(
        question: Question.fromJson(json),
        answers: jsonAnswers.map((a) => Answer.fromJson(a)).toList()
    );
  }

  QuestionAnswer({this.question, this.answers});
}