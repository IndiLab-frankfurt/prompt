// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionnaireResponse _$QuestionnaireResponseFromJson(
        Map<String, dynamic> json) =>
    QuestionnaireResponse(
      name: json['name'] as String,
      questionnaireName: json['questionnaire_name'] as String,
      questionText: json['question_text'] as String,
      response: json['response'] as String,
      dateSubmitted: DateTime.parse(json['date_submitted'] as String),
    );

Map<String, dynamic> _$QuestionnaireResponseToJson(
        QuestionnaireResponse instance) =>
    <String, dynamic>{
      'questionnaire_name': instance.questionnaireName,
      'name': instance.name,
      'question_text': instance.questionText,
      'response': instance.response,
      'date_submitted':
          QuestionnaireResponse._dateSubmittedToJson(instance.dateSubmitted),
    };
