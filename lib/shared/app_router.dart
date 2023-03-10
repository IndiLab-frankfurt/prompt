import 'package:flutter/material.dart';
import 'package:prompt/data/assessments.dart';
import 'package:prompt/screens/assessments/plan_prompt_screen.dart';
import 'package:prompt/screens/main/change_plan_timing_screen.dart';
import 'package:prompt/screens/main/data_privacy_screen.dart';
import 'package:prompt/screens/main/forgot_password_screen.dart';
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
import 'package:prompt/viewmodels/plan_prompt_view_model.dart';
import 'package:prompt/viewmodels/plan_timing_view_model.dart';
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
            child: LoginScreen());
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

      case AppScreen.ForgotPassword:
        screen = ForgotPasswordScreen();
        break;

      case AppScreen.Questionnaire:
        final questionnaire = settings.arguments as Questionnaire;
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: questionnaire),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_DidYouLearn:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_DidYouLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_WhyNotLearn:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_WhyNotLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_NextStudySession:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_NextStudySession),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.AA_PreviousStudySession:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_PreviousStudySession),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.RememberToLearn:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: RememberToLearn),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.ReminderTestToday:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderTestToday),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.ReminderNextList:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderNextList),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.WeeklyQuestions:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: WeeklyQuestions),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.ReminderTestTomorrow:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderTestTomorrow),
            child: MultiPageQuestionnaire());
        break;

      case AppScreen.PlanPrompt:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<PlanPromptViewModel>(),
            child: PlanPromptScreen());
        break;

      case AppScreen.PlanTimingChange:
        screen = ChangePlanTimingScreen(
            vm: PlanTimingViewModel(
                name: AppScreen.PlanTimingChange.name,
                dataService: locator.get<DataService>(),
                studyService: locator.get<StudyService>()));
        break;

      case AppScreen.ScreenSelect:
        screen = ScreenSelectionScreen();
        break;

      case AppScreen.DataPrivacy:
        screen = DataPrivacyScreen();
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
