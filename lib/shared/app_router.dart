import 'package:flutter/material.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/services/locator.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/screens/assessments/multi_page_questionnaire_screen.dart';
import 'package:prompt/screens/main/about_screen.dart';
import 'package:prompt/screens/main/screen_selection.dart';
import 'package:prompt/screens/onboarding/dashboard_screen.dart';
import 'package:prompt/screens/onboarding/login_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/onboarding/onboarding_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/enums.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/viewmodels/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    locator<LoggingService>().logEvent("navigation", data: settings.name ?? "");
    if (settings.name == null) {
      return MaterialPageRoute(builder: (_) {
        return Scaffold(
            body: Center(
          child: Text('No route defined for ${settings.name}'),
        ));
      });
    }
    var appScreen = AppScreen.values.byName(settings.name!);
    Widget screen;
    switch (appScreen) {
      case AppScreen.Login:
        screen = ChangeNotifierProvider<LoginViewModel>(
            create: (_) => LoginViewModel(
                locator.get<UserService>(), locator.get<NavigationService>()),
            child: LoginScreen(
              backgroundColor1: Color(0xFFFFF3E0),
              backgroundColor2: Color(0xFFFFF3E0),
              highlightColor: Colors.blue,
              foregroundColor: Color(0xFFFFF3E0),
            ));
        break;

      case AppScreen.Mainscreen:
        screen = ChangeNotifierProvider(
          create: (_) => DashboardViewModel(locator.get<StudyService>()),
          child: DashboardScreen(),
        );
        break;

      case AppScreen.Onboarding:
        screen = ChangeNotifierProvider(
            create: (_) => OnboardingViewModel(locator.get<StudyService>(),
                locator.get<DataService>(), locator.get<RewardService>()),
            child: OnboardingScreen());
        break;

      case AppScreen.RewardSelection:
        screen = RewardSelectionScreen();
        break;

      case AppScreen.AboutPrompt:
        screen = AboutScreen();
        break;

      case AppScreen.Questionnaire:
        final questionnaire = settings.arguments as Questionnaire;
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: questionnaire),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_DidYouLearn:
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: AA_DidYouLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_WhyNotLearn:
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: AA_WhyNotLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_NextStudySession:
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: AA_NextStudySession),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_PreviousStudySession:
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: AA_PreviousStudySession),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.RememberToLearn:
        screen = ChangeNotifierProvider(
            create: (_) => MultiPageQuestionnaireViewModel(
                locator.get<DataService>(),
                rewardService: locator.get<RewardService>(),
                studyService: locator.get<StudyService>(),
                questionnaire: RememberToLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.ScreenSelect:
        screen = ScreenSelectionScreen();
        break;

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
              body: Center(
            child: Text('No route defined for ${settings.name}'),
          ));
        });
    }

    return MaterialPageRoute(
        settings: RouteSettings(name: appScreen.name), builder: (_) => screen);
  }
}
