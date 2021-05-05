import 'package:json_annotation/json_annotation.dart';

part 'question_content.g.dart';

/// A single Question is represented by this class.
@JsonSerializable()
class QuestionContent {
  final String question;
  final List<String> alternatives;
  final List<String> subAlternatives;

  int _chAlt = -1;
  int _chSAlt = -1;

  @JsonKey(ignore: true)
  int get chosenAlternative => this._chAlt;
  @JsonKey(ignore: true)
  set chosenAlternative(int n) => this._chAlt = n;
  @JsonKey(ignore: true)
  int get chosenSubAlternative => this._chSAlt;
  @JsonKey(ignore: true)
  set chosenSubAlternative(int n) => this._chSAlt = n;

  QuestionContent(
    this.question,
    this.alternatives,
    this.subAlternatives,
  );

  factory QuestionContent.fromJson(Map<String, dynamic> json)
    => _$QuestionContentFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionContentToJson(this);
}
