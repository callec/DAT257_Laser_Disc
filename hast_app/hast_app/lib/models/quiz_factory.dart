import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:hast_app/common/quiz_content.dart';

class QuizFactory {

  ///Load in Quiz JSON file
  static Future<String> getJson(String fileName) {
    return rootBundle.loadString('assets/quizzes/$fileName.json');
  }

  /// Decode JSON file to a QuizContent object
  static Future<QuizContent> createQuiz(String fileName) async {
    return QuizContent.fromJson(jsonDecode(await getJson(fileName)));
  }

}
