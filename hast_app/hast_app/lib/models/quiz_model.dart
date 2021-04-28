//import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_factory.dart';

/// Handles the inner workings of a Quiz.
///
/// Keeps the titles, questions, and enables traversing between them.
class QuizModel with ChangeNotifier {
  // TODO do we need a QuizContent class? or same title for 8 qs?
  QuizContent _quiz;
  int _questionNumber = 0;
  int _answered = 0;
  String _questionTitle;

  List<String> _resultText;
  List<QuestionContent> _questions;

  List<QuestionContent> get questions => _questions;
  QuestionContent get currentQuestion => _questions[_questionNumber];
  int get currentNumber => _questionNumber;
  String get title => _questionTitle;
  List<String> get resultList => _resultText;
  bool get finished {
    for (QuestionContent q in this._questions) {
      if (q.chosenSubAlternative == -1) {
        return false;
      }
    }

    return true;
  }

  QuizModel() {
    this.reset();
  }

  /// Reset the quiz to the starting point.
  void reset(){
    _quiz = QuestionFactory.createStandardQuiz();
    _questions = _quiz.questions;
    _questionTitle = _quiz.quizTitle;
    _resultText = _quiz.resultText;
    _questionNumber = 0;
  }

  /// Change question forward.
  void nextQuestion() {
    if (_questionNumber < (_questions.length - 1)) ++_questionNumber;

    notifyListeners();
  }

  /// Change question backward.
  void prevQuestion() {
    if (_questionNumber > 0) --_questionNumber;

    notifyListeners();
  }

  /// Set which alternative has been chosen.
  void setAlternative(int n) {
    if (this.currentQuestion.chosenAlternative == n)
      this.currentQuestion.chosenAlternative = -1;
    else
      this.currentQuestion.chosenAlternative = n;

    notifyListeners();
  }

  /// Set which subalternative has been chosen.
  void setSubAlternative(int n) {
    this.currentQuestion.chosenSubAlternative = n;

    notifyListeners();
  }
}
