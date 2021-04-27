//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question.dart';
import 'package:hast_app/models/quiz_factory.dart';

class QuizModel with ChangeNotifier {
  // TODO do we need a QuizContent class? or same title for 8 qs?
  int _questionNumber = 0;
  String _questionTitle = 'fetch this title somehow';
  List<QuestionContent> _questions = QuestionFactory.createStandardQuiz();

  List<QuestionContent> get questions => _questions;

  QuestionContent get currentQuestion => _questions[_questionNumber];

  int get currentNumber => _questionNumber;

  String get title => _questionTitle;

  void reset(){
    _questions = QuestionFactory.createStandardQuiz();
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
