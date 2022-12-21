import 'package:json_annotation/json_annotation.dart';
part 'questionnaire.g.dart';

@JsonSerializable()
class Questionnaire {
  final String title;
  final String type;
  final String name;

  Questionnaire({required this.title, required this.type, required this.name});

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}
