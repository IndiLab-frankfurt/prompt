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
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: questionnaire));
        break;

      case AppScreen.AA_DidYouLearn:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_DidYouLearn));
        break;

      case AppScreen.AA_WhyNotLearn:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_WhyNotLearn));
        break;

      case AppScreen.AA_NextStudySession:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_NextStudySession));
        break;

      case AppScreen.AA_PreviousStudySession:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: AA_PreviousStudySession));
        break;

      case AppScreen.RememberToLearn:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: RememberToLearn));
        break;

      case AppScreen.ReminderTestToday:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderTestToday));
        break;

      case AppScreen.ReminderNextList:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderNextList));
        break;

      case AppScreen.WeeklyQuestions:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: WeeklyQuestions));
        break;

      case AppScreen.ReminderTestTomorrow:
        screen = MultiPageQuestionnaire(
            vm: locator.get<MultiPageQuestionnaireViewModel>(
                param1: ReminderTestTomorrow));
        break;

      case AppScreen.PlanPrompt:
        screen = ChangeNotifierProvider(
            create: (_) => locator.get<PlanPromptViewModel>(),
            child: PlanPromptScreen());
        break;

      case AppScreen.PlanTimingChange:
        screen = ChangePlanTimingScreen(
            vm: PlanTimingViewModel(
                locator.get<DataService>(), locator.get<StudyService>()));
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
