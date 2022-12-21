import 'package:json_annotation/json_annotation.dart';

part 'questionnaire_response.g.dart';

@JsonSerializable()
class QuestionnaireResponse {
  final String name;
  final String questionnaireName;
  final String questionText;
  final String response;
  final DateTime dateSubmitted;

  QuestionnaireResponse({
    required this.name,
    required this.questionnaireName,
    required this.questionText,
    required this.response,
    required this.dateSubmitted,
  });

  factory QuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireResponseToJson(this);
}
