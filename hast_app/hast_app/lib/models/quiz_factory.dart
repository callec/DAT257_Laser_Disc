import 'dart:convert';
import 'package:hast_app/common/quiz_content.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class QuestionFactory {
  ///Load in Quiz JSON file
  static Future<String> getJson() {
    return rootBundle.loadString('assets/ReflectionQuiz.json');
  }

  ///Decode JSON file to a QuizContent object
  static Future<QuizContent> createStandardQuiz() async {
    return QuizContent.fromJson(jsonDecode(await getJson()));
  }
}
