//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_factory.dart';

class QuizModel with ChangeNotifier {
  // TODO do we need a QuizContent class? or same title for 8 qs?
  QuizContent _quiz;
  int _questionNumber = 0;
  String _questionTitle;

  List<String> _resultText;
  List<QuestionContent> _questions;

  List<QuestionContent> get questions => _questions;
  QuestionContent get currentQuestion => _questions[_questionNumber];
  int get currentNumber => _questionNumber;
  String get title => _questionTitle;
  List<String> get resultList => _resultText;

  QuizModel() {
    this.reset();
  }

  void reset(){
    _quiz = QuestionFactory.createStandardQuiz();
    _questions = _quiz.questions;
    _questionTitle = _quiz.quizTitle;
    _resultText = _quiz.resultText;
    _questionNumber = 0;
  }

  void nextQuestion() {
    if (_questionNumber < (_questions.length - 1)) ++_questionNumber;

    notifyListeners();
  }

  void prevQuestion() {
    if (_questionNumber > 0) --_questionNumber;

    notifyListeners();
  }

  void setAlternative(int n) {
    if (this.currentQuestion.chosenAlternative == n)
      this.currentQuestion.chosenAlternative = -1;
    else
      this.currentQuestion.chosenAlternative = n;
    notifyListeners();
  }

  void setSubAlternative(int n) {
    this.currentQuestion.chosenSubAlternative = n;

    notifyListeners();
  }
}
