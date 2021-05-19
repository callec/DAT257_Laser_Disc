import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/common/quiz_content.dart';

/// Handles the inner workings of a Quiz.
/// Stores the title, questions, and enables traversing between them.
class QuizModel with ChangeNotifier {
  late QuizContent _quiz;

  int _questionNumber = 0;
  List<QuestionContent> _questions = <QuestionContent>[];

  bool quizLoaded = false;
  bool _hasAnswered = false;

  List<QuestionContent> get questions => _questions;

  QuestionContent get currentQuestion => _questions[_questionNumber];

  int get currentNumber => _questionNumber;

  int get numberOfQuestions => _questions.length;
  bool get hasAnswered => currentQuestion.chosenSubAlternative != -1;

  String get title => _quiz.quizTitle;

  String get subAltText => _quiz.subAltText;

  List<String> get subAlternatives => _quiz.subAlternatives;

  List<String> get resultList => _quiz.resultText;

  bool get finished {
    for (QuestionContent q in this._questions) {
      if (q.chosenSubAlternative == -1) {
        return false;
      }
    }
    return true;
  }

  /// Inject a new Quiz into the model
  void loadQuiz(QuizContent quiz) {
    _quiz = quiz;
    _questions = _quiz.questions;

    _reset();

    quizLoaded = true;
  }

  /// Reset the quiz to the starting point.
  void _reset() {
    _questions.forEach((element) {
      element.chosenAlternative = -1;
      element.chosenSubAlternative = -1;
    });
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

  /// Updates current question in model if user clicks question in questionDrawer
  void setQuestion(int n) {
    if (n > -1 && n < _questions.length) {
      _questionNumber = n;
      notifyListeners();
    }
  }

  /// Set which alternative has been chosen.
  void setAlternative(int n) {
    if (this.currentQuestion.chosenAlternative == n) {
      this.currentQuestion.chosenAlternative = -1;
    } else {
      this.currentQuestion.chosenAlternative = n;
    }

    notifyListeners();
  }

  /// Set which sub alternative has been chosen.
  void setSubAlternative(int n) {
    if (this.currentQuestion.chosenSubAlternative == n)
      this.currentQuestion.chosenSubAlternative = -1;
    else
      this.currentQuestion.chosenSubAlternative = n;

    notifyListeners();
  }
}
