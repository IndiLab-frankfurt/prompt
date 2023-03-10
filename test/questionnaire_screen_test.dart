import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/screens/assessments/multi_page_questionnaire_screen.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:provider/provider.dart';
import 'package:prompt/services/locator.dart';
import 'mocks/mock_services.dart';

void main() {
  setUpAll(() {
    setupLocator();
  });

  testWidgets("Questionnaire with multiple pages", (tester) async {
    var vm = MultiPageQuestionnaireViewModel(
        name: "Test",
        studyService: MockStudyService(),
        questionnaire: AA_NextStudySession);

    var widget = MaterialApp(
      home: ChangeNotifierProvider(
          create: (_) => vm, child: MultiPageQuestionnaire()),
    );

    await tester.pumpWidget(widget);
    expect(vm.page, 0);

    // On the first page, the submit button and previous button should not be there
    expect(find.byKey(ValueKey("submitButton")).hitTestable(), findsNothing);
    expect(find.byKey(ValueKey("backButton")).hitTestable(), findsNothing);

    await tester.tap(find.byKey(ValueKey("nextButton")));
    expect(vm.page, 1);
  });
}
