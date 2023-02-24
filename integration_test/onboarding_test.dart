import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/screens/onboarding/onboarding_screen.dart';
import 'package:prompt/screens/onboarding/welcome_screen.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    setupLocator();
    await locator<SettingsService>().initialize();
    var settingsService = locator<SettingsService>();
    settingsService.setSetting(SettingsKeys.username, "123456");
    settingsService.setSetting(SettingsKeys.username, "Prompt1234");

    await locator<DataService>().initialize();
    var dataService = locator<DataService>();
    var userData =
        UserData(user: "123456", startDate: DateTime.now(), onboardingStep: 0);
    dataService.setUserDataCache(userData);
    await locator<UserService>().initialize();
    await locator<ApiService>().initialize();
  });

  group('onboarding test', () {
    testWidgets('Verify Screen Sequence', (tester) async {
      var vm = OnboardingViewModel(locator.get<StudyService>(),
          locator.get<DataService>(), locator.get<RewardService>());
      var screen =
          ChangeNotifierProvider(create: (_) => vm, child: OnboardingScreen());

      var app = MaterialApp(
        home: screen,
      );

      await tester.pumpWidget(app);
      await tester.pumpAndSettle();

      // Verify that the first page is the welcome screen
      expect(find.byType(WelcomeScreen), findsOneWidget);

      // Finds the next button
      final Finder nextButton = find.text('Weiter');

      // Emulate a tap on the floating action button.
      await tester.tap(nextButton);

      // // Trigger a frame.
      // await tester.pumpAndSettle();

      // // Verify that the second page is the introduction video
      // expect(find.byKey(ValueKey(OnboardingStep.welcome)), findsOneWidget)

      // // Verify the counter increments by 1.
      // expect(find.text('1'), findsOneWidget);
    });
  });
}
