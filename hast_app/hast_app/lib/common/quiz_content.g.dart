// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizContent _$QuizContentFromJson(Map<String, dynamic> json) {
  return QuizContent(
    json['quizTitle'] as String,
    json['quizInfo'] as String,
    (json['resultText'] as List<dynamic>).map((e) => e as String).toList(),
    (json['questions'] as List<dynamic>)
        .map((e) => QuestionContent.fromJson(e as Map<String, dynamic>))
        .toList(),
      json['subAltText'] as String,
    (json['subAlternatives'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$QuizContentToJson(QuizContent instance) =>
    <String, dynamic>{
      'quizTitle': instance.quizTitle,
      'quizInfo': instance.quizInfo,
      'resultText': instance.resultText,
      'questions': instance.questions.map((e) => e.toJson()).toList(),
      'subAltText': instance.subAltText,
      'subAlternatives': instance.subAlternatives,
    };
