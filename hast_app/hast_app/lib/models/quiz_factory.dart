import 'dart:convert';
import 'package:hast_app/common/quiz_content.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';

class QuestionFactory {

  static Future<String> getJson(){
    return rootBundle.loadString('ReflectionQuiz.json');
  }

  static Future<QuizContent> createStandardQuiz() async {
    return QuizContent.fromJson(jsonDecode(await getJson()));
  }
}
