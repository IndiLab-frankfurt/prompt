import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/screens/assessments/multi_page_questionnaire_screen.dart';
import 'package:prompt/screens/main/about_screen.dart';
import 'package:prompt/screens/main/screen_selection.dart';
import 'package:prompt/screens/onboarding/dashboard_screen.dart';
import 'package:prompt/screens/onboarding/login_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/onboarding/session_zero_screen.dart';
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
    switch (appScreen) {
      case AppScreen.Login:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<LoginViewModel>(
                create: (_) => LoginViewModel(locator.get<UserService>(),
                    locator.get<NavigationService>()),
                child: LoginScreen(
                  backgroundColor1: Color(0xFFFFF3E0),
                  backgroundColor2: Color(0xFFFFF3E0),
                  highlightColor: Colors.blue,
                  foregroundColor: Color(0xFFFFF3E0),
                )));

      case AppScreen.Mainscreen:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) =>
                      DashboardViewModel(locator.get<StudyService>()),
                  child: DashboardScreen(),
                ));

      case AppScreen.Onboarding:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => OnboardingViewModel(locator.get<StudyService>(),
                    locator.get<DataService>(), locator.get<RewardService>()),
                child: SessionZeroScreen()));

      case AppScreen.RewardSelection:
        return MaterialPageRoute(builder: (_) => RewardSelectionScreen());

      case AppScreen.AboutPrompt:
        return MaterialPageRoute(builder: (_) => AboutScreen());

      case AppScreen.Questionnaire:
        final questionnaire = settings.arguments as Questionnaire;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    studyService: locator.get<StudyService>(),
                    screenName: appScreen,
                    questionnaire: questionnaire),
                child: MultiPageQuestionnaire()));

      case AppScreen.AA_DidYouLearn:
        return CupertinoPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    studyService: locator.get<StudyService>(),
                    screenName: appScreen,
                    questionnaire: AA_DidYouLearn),
                child: MultiPageQuestionnaire()));

      case AppScreen.AA_WhyNotLearn:
        return CupertinoPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    studyService: locator.get<StudyService>(),
                    screenName: appScreen,
                    questionnaire: AA_WhyNotLearn),
                child: MultiPageQuestionnaire()));

      case AppScreen.AA_NextStudySession:
        return CupertinoPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    studyService: locator.get<StudyService>(),
                    screenName: appScreen,
                    questionnaire: AA_NextStudySession),
                child: MultiPageQuestionnaire()));

      case AppScreen.AA_PreviousStudySession:
        return CupertinoPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    studyService: locator.get<StudyService>(),
                    screenName: appScreen,
                    questionnaire: AA_PreviousStudySession),
                child: MultiPageQuestionnaire()));

      case AppScreen.ScreenSelect:
        return CupertinoPageRoute(builder: (_) => ScreenSelectionScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
              body: Center(
            child: Text('No route defined for ${settings.name}'),
          ));
        });
    }
  }
}
