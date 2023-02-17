import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/questionnaire_submission.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/shared/enums.dart';

import 'experiment_service_test.dart';

void main() {
  test("JSON gets built correctly", () {
    // const questionnaire =
    var date = DateTime.now();

    var response = QuestionnaireResponse(
        name: "ach",
        questionnaireName: "questionnaireId",
        questionText: "Was ist dein Plan?",
        response: "Nie wieder Vokabeln lernen",
        dateSubmitted: date);

    var responsejson = response.toJson();

    expect(responsejson["question_text"], "Was ist dein Plan?");
    expect(responsejson["date_submitted"], date.toIso8601String());
  });

  test("JSON gets submitted correctly", () async {
    // const questionnaire =
    var date = DateTime.now();
    var questionnaireid = "questionnaire1";

    var response1 = QuestionnaireResponse(
        name: "Frage1",
        questionnaireName: questionnaireid,
        questionText: "Frage 1?",
        response: "Antwort 1",
        dateSubmitted: date);

    var response2 = QuestionnaireResponse(
        name: "Frage2",
        questionnaireName: questionnaireid,
        questionText: "Frage 2?",
        response: "Antwort 2",
        dateSubmitted: date);

    var responses = [response1, response2];

    var questionnaireSubmission = QuestionnaireSubmission(
        questionnaireName: questionnaireid,
        dateSubmitted: date,
        dateStarted: date.subtract(Duration(minutes: 5)),
        responses: responses);

    var settingsService = mockSettingsService;
    mockSettingsService.setSetting(SettingsKeys.username, "123456");
    mockSettingsService.setSetting(SettingsKeys.password, "Prompt1234");
    var apiService = ApiService(settingsService);
    ApiService.serverUrl = "http://localhost:8000";
    var response = await apiService
        .submitQuestionnaireResponses(questionnaireSubmission.toJson());
    expect(response, true);
  });
}
