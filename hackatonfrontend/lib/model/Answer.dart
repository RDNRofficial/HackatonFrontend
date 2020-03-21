class Answer {
  String before;
  String after;
  bool solution;
  int question;
  double x;
  double y;
  double size_before;
  double size_after;
  bool clicked;

  Answer({this.before, this.after, this.solution, this.question, this.x, this.y, this.size_before, this.size_after}) {
    this.clicked = false;
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      before: json['before'],
      after: json['after'],
      solution: json['solution'],
      question: json['question'],
      x: double.parse(json['x']),
      y: double.parse(json['y']),
      size_before: double.parse(json['size_before']),
      size_after: double.parse(json['size_after']),

    );
  }
}
