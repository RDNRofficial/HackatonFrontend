class Answer {
  String before;
  String after;
  bool solution;
  int question;
  int x;
  int y;
  bool clicked;

  Answer({this.before, this.after, this.solution, this.question, this.x, this.y}) {
    this.clicked = false;
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      before: json['before'],
      after: json['after'],
      solution: json['solution'],
      question: json['question'],
      x: json['x'],
      y: json['y'],
    );
  }
}
