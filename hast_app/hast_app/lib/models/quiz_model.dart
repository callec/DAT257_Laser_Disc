//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question.dart';
import 'package:hast_app/models/quiz_factory.dart';

//Created Carl
//Edited by Erik, Felix, Sam

class QuizModel with ChangeNotifier {
  // TODO do we need a QuizContent class? or same title for 8 qs?
  int _questionNumber = 0;
  String _questionTitle = 'fetch this title somehow';
  List<QuestionContent> _questions = QuestionFactory.createStandardQuiz();

  QuestionContent get currentQuestion => _questions[_questionNumber];
  int get currentNumber => _questionNumber;
  String get title => _questionTitle;
  int get numberOfQuestions => _questions.length;

  void nextQuestion() {
    if (_questionNumber < (_questions.length - 1)) ++_questionNumber;

    notifyListeners();
  }

  void prevQuestion() {
    if (_questionNumber > 0) --_questionNumber;

    notifyListeners();
  }

  //Updates current question in model if user clicks question in questionDrawer
  void setQuestion(int n){
    if (n > - 1 && n < _questions.length) {
      _questionNumber = n;
      notifyListeners();
    }
  }

  void setAlternative(int n) {
    if (this.currentQuestion.chosenAlternative == n) {
      this.currentQuestion.chosenAlternative = -1;
      notifyListeners();
      return;
    }

    this.currentQuestion.chosenAlternative = n;

    notifyListeners();
  }

  void setSubAlternative(int n) {
    this.currentQuestion.chosenSubAlternative = n;

    notifyListeners();
  }
}
