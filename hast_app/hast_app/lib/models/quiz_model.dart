import 'package:flutter/foundation.dart';
import 'package:hast_app/common/question_content.dart';
import 'package:hast_app/common/quiz_content.dart';
import 'package:hast_app/models/quiz_factory.dart';


/// Handles the inner workings of a Quiz.
///
/// Keeps the titles, questions, and enables traversing between them.
class QuizModel with ChangeNotifier {
  // TODO do we need a QuizContent class? or same title for 8 qs?
  late QuizContent _quiz;
  late int _questionNumber = 0;
  int _answered = 0;
  late String _questionTitle;

  late List<String> _resultText;
  late List<QuestionContent> _questions = <QuestionContent>[];

  bool loading = true;

  List<QuestionContent> get questions => _questions;
  QuestionContent get currentQuestion => _questions[_questionNumber];
  int get currentNumber => _questionNumber;
  String get title => _questionTitle;
  int get numberOfQuestions => _questions.length;
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
  /// Waits for the JSON file to decode, this is done asynchronous
  void reset(){
    loading = true;

    QuestionFactory.createStandardQuiz().then((value) {
      _quiz = value;
      _questions = _quiz.questions;
      _questionTitle = _quiz.quizTitle;
      _resultText = _quiz.resultText;
      _questionNumber = 0;

      loading = false;
      notifyListeners();
    });

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
  void setQuestion(int n){
    if (n > - 1 && n < _questions.length) {
      _questionNumber = n;
      notifyListeners();
    }
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
    if (this.currentQuestion.chosenSubAlternative == n)
      this.currentQuestion.chosenSubAlternative = -1;
    else
      this.currentQuestion.chosenSubAlternative = n;

    notifyListeners();
  }
}
