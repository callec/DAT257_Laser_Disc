import 'package:hast_app/common/question_content.dart';

/// A single quiz is represented by this class
class QuizContent {
  final String _quizTitle;
  final List<String> _resultText;
  final List<QuestionContent> _questions;

  String get quizTitle => _quizTitle;
  List<String> get resultText => _resultText;
  List<QuestionContent> get questions => _questions;

  QuizContent(
    this._quizTitle,
    this._resultText,
    this._questions
  );
}
