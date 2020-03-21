
class Question {
  String question;
  String background;
  String audio;
  int score;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      background: json['background'],
      audio: json['audio'],
      score: json['score'],
    );
  }

  Question({this.question, this.background, this.audio, this.score});
}