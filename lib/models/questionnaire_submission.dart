import 'package:json_annotation/json_annotation.dart';
import 'package:prompt/models/questionnaire_response.dart';
part 'questionnaire_submission.g.dart';

@JsonSerializable()
class QuestionnaireSubmission {
  final String questionnaireName;
  final DateTime dateSubmitted;
  final DateTime dateStarted;
  final List<QuestionnaireResponse> responses;

  QuestionnaireSubmission({
    required this.questionnaireName,
    required this.dateSubmitted,
    required this.dateStarted,
    required this.responses,
  });

  factory QuestionnaireSubmission.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireSubmissionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireSubmissionToJson(this);
}
