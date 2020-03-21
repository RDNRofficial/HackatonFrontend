import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:hackatonfrontend/model/Question.dart';


class Rest {
  static final URL_QUESTION = "";

  static final Rest instance = Rest.internal();
  factory Rest() => instance;

  String url;

  Rest.internal() {
    this.url = "";
  }

  Future<Question> fetchQuestion() async {
    final response = await http.get(this.url);
    if (response.statusCode == 200) {
      return Question.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load question');
    }
  }
}