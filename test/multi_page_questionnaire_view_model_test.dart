import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/locator.dart';

void main() {
  setUp(() {
    setupLocator();
  });
  testWidgets("Questionnaire View Model with multiple pages", (tester) async {
    // var vm = MultiPageQuestionnaireViewModel(
    //                 locator.get<DataService>(),
    //                 rewardService: locator.get<RewardService>(),
    //                 studyService: locator.get<StudyService>(),
    //                 screenName: appScreen,
    //                 questionnaire: AA_NextStudySession),

    // expect(vm.page, 0);

    // // On the first page, the submit button and previous button should not be there
    // expect(find.byKey(ValueKey("submitButton")).hitTestable(), findsNothing);
    // expect(find.byKey(ValueKey("backButton")).hitTestable(), findsNothing);

    // await tester.tap(find.byKey(ValueKey("nextButton")));
    // expect(vm.page, 1);
  });
}
