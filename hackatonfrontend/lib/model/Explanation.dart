class Explanation {
  String image;
  String text;
  int diyList;

  factory Explanation.fromJson(Map<String, dynamic> json) {
    return Explanation(
      image: json['image'],
      text: json['text'],
      diyList: json['diyList']
    );
  }

  Explanation({this.image, this.text, this.diyList});
}