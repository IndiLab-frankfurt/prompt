import 'package:json_annotation/json_annotation.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/viewmodels/choice_question_view_model.dart';

part 'questionnaire_response.g.dart';

@JsonSerializable()
class QuestionnaireResponse {
  String questionnaireName;
  final String name;
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

  static List<QuestionnaireResponse> fromQuestionnaire(
      Questionnaire questionnaire) {
    List<QuestionnaireResponse> responses = [];
    for (var q in questionnaire.questions) {
      if (q is ChoiceQuestionViewModel) {
        var response = "";
        if (q.selectedChoices.length > 1) {
          response = q.selectedChoices.join(", ");
        } else if (q.selectedChoices.length == 1) {
          response = q.selectedChoices.first;
        }
        responses.add(QuestionnaireResponse(
          name: q.name,
          questionnaireName: questionnaire.name,
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
