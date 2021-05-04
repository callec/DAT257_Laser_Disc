// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionContent _$QuestionContentFromJson(Map<String, dynamic> json) {
  return QuestionContent(
    json['number'] as int,
    json['question'] as String,
    (json['alternatives'] as List<dynamic>).map((e) => e as String).toList(),
    (json['subAlternatives'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$QuestionContentToJson(QuestionContent instance) =>
    <String, dynamic>{
      'number': instance.number,
      'question': instance.question,
      'alternatives': instance.alternatives,
      'subAlternatives': instance.subAlternatives,
    };
