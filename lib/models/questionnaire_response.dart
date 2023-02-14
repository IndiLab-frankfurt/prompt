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
    return q.questions.map((q) {
      if (q is ChoiceQuestion) {
        if (q.selectedChoices.length > 1) {
          return QuestionnaireResponse(
            name: q.name,
            questionnaireName: q.name,
            questionText: q.questionText,
            response: q.selectedChoices.join(", "),
            dateSubmitted: DateTime.now().toLocal(),
          );
        } else {
          return QuestionnaireResponse(
            name: q.name,
            questionnaireName: q.name,
            questionText: q.questionText,
            response: q.selectedChoices.first,
            dateSubmitted: DateTime.now().toLocal(),
          );
        }
      } else {
        return QuestionnaireResponse(
          name: q.name,
          questionnaireName: q.name,
          questionText: q.questionText,
          response: "",
          dateSubmitted: DateTime.now().toLocal(),
        );
      }
    }).toList();
  }

  factory QuestionnaireResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireResponseToJson(this);
}
