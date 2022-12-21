// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questionnaire_submission.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionnaireSubmission _$QuestionnaireSubmissionFromJson(
        Map<String, dynamic> json) =>
    QuestionnaireSubmission(
      questionnaireName: json['questionnaire_name'] as String,
      dateSubmitted: DateTime.parse(json['date_submitted'] as String),
      dateStarted: DateTime.parse(json['date_started'] as String),
      responses: (json['responses'] as List<dynamic>)
          .map((e) => QuestionnaireResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionnaireSubmissionToJson(
        QuestionnaireSubmission instance) =>
    <String, dynamic>{
      'questionnaire_name': instance.questionnaireName,
      'date_submitted': instance.dateSubmitted.toIso8601String(),
      'date_started': instance.dateStarted.toIso8601String(),
      'responses': instance.responses.map((e) => e.toJson()).toList(),
    };
