import 'package:hast_app/common/question_content.dart';
import 'package:json_annotation/json_annotation.dart';

part 'quiz_content.g.dart';

/// A single quiz is represented by this class
@JsonSerializable(explicitToJson: true)
class QuizContent {
  final String quizTitle;
  final String quizInfo;
  final List<String> resultText;
  final List<QuestionContent> questions;

  QuizContent(
    this.quizTitle,
    this.quizInfo,
    this.resultText,
    this.questions
  );

  factory QuizContent.fromJson(Map<String, dynamic> json)
    => _$QuizContentFromJson(json);

  Map<String, dynamic> toJson() => _$QuizContentToJson(this);
}
