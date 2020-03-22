class DIYManual {
  String title;
  String titleImage;

  factory DIYManual.fromJson(Map<String, dynamic> json) {
    return DIYManual(
      title: json['title'],
      titleImage: json['title_image'],
    );
  }

  DIYManual({this.title, this.titleImage});
}