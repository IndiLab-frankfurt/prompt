import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/models/questionnaire_response.dart';
import 'package:prompt/models/questionnaire_submission.dart';
import 'package:prompt/screens/assessments/multi_page_questionnaire_screen.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:provider/provider.dart';

import 'experiment_service_test.dart';
import 'mocks/mock_services.dart';

void main() {
  testWidgets("Questionnaire responses submitted", (tester) async {
    var widget = MaterialApp(
      home: ChangeNotifierProvider(
          create: (_) => MultiPageQuestionnaireViewModel(MockDataService(),
              rewardService: MockRewardService(),
              studyService: MockStudyService(),
              screenName: AppScreen.AA_DidYouLearn,
              questionnaire: AA_DidYouLearn),
          child: MultiPageQuestionnaire()),
    );

    await tester.pumpWidget(widget);
  });
}
