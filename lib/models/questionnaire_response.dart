import 'package:json_annotation/json_annotation.dart';
import 'package:prompt/models/question.dart';
import 'package:prompt/models/questionnaire.dart';

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

  static List<QuestionnaireResponse> fromQuestionnaire(Questionnaire q) {
    List<QuestionnaireResponse> responses = [];
    for (var q in q.questions) {
      if (q is ChoiceQuestion) {
        var response = "";
        if (q.selectedChoices.length > 1) {
          response = q.selectedChoices.join(", ");
        } else {
          response = q.selectedChoices.first;
        }
        responses.add(QuestionnaireResponse(
          name: q.name,
          questionnaireName: q.name,
          questionText: q.questionText,
          response: response,
          dateSubmitted: DateTime.now().toLocal(),
        ));
      }
    }
    return responses;
  }

  factory QuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireResponseToJson(this);
}
