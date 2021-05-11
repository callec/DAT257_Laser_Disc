import 'dart:convert';
import 'package:hast_app/common/quiz_content.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class QuestionFactory {
  ///Load in Quiz JSON file
  static Future<String> getJson(String fileName) {
    return rootBundle.loadString('assets/$fileName.json');
  }

  static Future<QuizContent> createQuiz(String fileName) async {
    return QuizContent.fromJson(jsonDecode(await getJson(fileName)));
  }

  ///Decode JSON file to a QuizContent object
  static Future<QuizContent> createStandardQuiz() async {
    return QuizContent.fromJson(jsonDecode(await getJson("ReflectionQuiz")));
  }
}
