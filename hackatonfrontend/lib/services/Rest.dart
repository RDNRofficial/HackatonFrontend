import 'package:hackatonfrontend/model/Answer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


import 'package:hackatonfrontend/model/Question.dart';


class Rest {
  static final URL_QUESTION = "rest/question/";
  static final URL_ANSWER = "rest/answer/";

  static final Rest instance = Rest.internal();
  factory Rest() => instance;

  String url;

  Rest.internal() {
    this.url = "http://bitschi.hopto.org:8000/";
  }

  Future<List<Question>> fetchQuestionList() async {
    final response = await http.get(this.url + Rest.URL_QUESTION);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((q) => Question.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load question');
    }
  }

  Future<List<Answer>> fetchAnswerList() async {
    final response = await http.get(this.url + Rest.URL_ANSWER);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((q) => Answer.fromJson(q)).toList();
    } else {
      throw Exception('Failed to load question');
    }
  }


}