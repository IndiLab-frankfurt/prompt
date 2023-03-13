// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/study_service.dart';

void main() {
  setUp(() {
    setupLocator();
  });
  test('Submitting PlanPrompt response should yield rewards', () {
    // Verify that our counter has incremented.
    // expService.schedulePrompts(1);
    var response = QuestionnaireResponse(
        name: "name",
        questionnaireName: "PlanPrompt",
        questionText: "",
        response: "",
        dateSubmitted: DateTime.now().toLocal());

    var studyService = locator.get<StudyService>();

    studyService.submitResponses([response]);

    var rewardService = locator.get<RewardService>();

    expect(rewardService.scheduledRewards[0], greaterThanOrEqualTo(10));
  });
}
