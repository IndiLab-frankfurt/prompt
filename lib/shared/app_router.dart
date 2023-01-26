import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/screens/about_screen.dart';
import 'package:prompt/screens/about_video_screen.dart';
import 'package:prompt/screens/assessments/disributed_learning_video_screen.dart';
import 'package:prompt/screens/assessments/evening_assessment_screen.dart';
import 'package:prompt/screens/assessments/final_assessment_screen.dart';
import 'package:prompt/screens/assessments/multi_page_questionnaire_screen.dart';
import 'package:prompt/screens/change_mascot_screen.dart';
import 'package:prompt/screens/internalisation/daily_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/default_reminder_screen.dart';
import 'package:prompt/screens/login_screen.dart';
import 'package:prompt/screens/dashboard_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/session_zero/session_zero_screen.dart';
import 'package:prompt/screens/study_complete_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/change_mascot_view_model.dart';
import 'package:prompt/viewmodels/daily_internalisation_view_model.dart';
import 'package:prompt/viewmodels/evening_assessment_view_model.dart';
import 'package:prompt/viewmodels/final_asssessment_view_model.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    locator<LoggingService>().logEvent("navigation", data: settings.name ?? "");
    switch (settings.name) {
      case RouteNames.LOG_IN:
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

      case RouteNames.NO_TASKS:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => DashboardViewModel(
                      locator.get<StudyService>(),
                      locator.get<DataService>(),
                      locator.get<NavigationService>()),
                  child: DashboardScreen(),
                ));

      case RouteNames.SESSION_ZERO:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => SessionZeroViewModel(locator.get<StudyService>(),
                    locator.get<DataService>(), locator.get<RewardService>()),
                child: SessionZeroScreen()));

      case RouteNames.DAILY_INTERNALISATION:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => DailyInternalisationViewModel(
                    locator.get<StudyService>(), locator.get<DataService>()),
                child: DailyInternalisationScreen()));

      case RouteNames.ASSESSMENT_EVENING:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => EveningAssessmentViewModel(
                    locator.get<StudyService>(), locator.get<DataService>()),
                child: EveningAssessmentScreen()));

      case RouteNames.ASSESSMENT_FINAL:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => FinalAssessmentViewModel(
                    locator.get<DataService>(), locator.get<StudyService>()),
                child: FinalAssessmentScreen()));

      case RouteNames.MASCOT_CHANGE:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => ChangeMascotViewModel(
                    locator.get<RewardService>(), locator.get<DataService>()),
                child: ChangeMascotScreen()));

      case RouteNames.REWARD_SELECTION:
        return MaterialPageRoute(builder: (_) => RewardSelectionScreen());

      case RouteNames.REMINDER_DEFAULT:
        return MaterialPageRoute(builder: (_) => DefaultReminderScreen());

      case RouteNames.VIDEO_DISTRIBUTED_LEARNING:
        return MaterialPageRoute(builder: (_) => DistributedLearningVideo());

      case RouteNames.ABOUT_PROMPT:
        return MaterialPageRoute(builder: (_) => AboutScreen());

      case RouteNames.ABOUT_PROMPT_VIDEO:
        return MaterialPageRoute(builder: (_) => AboutVideoScreen());

      case RouteNames.STUDY_COMPLETE:
        return MaterialPageRoute(builder: (_) => StudyCompleteScreen());

      case RouteNames.QUESTIONNAIRE:
        final questionnaire = settings.arguments as Questionnaire;
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MultiPageQuestionnaireViewModel(
                    locator.get<DataService>(),
                    questionnaire: questionnaire),
                child: MultiPageQuestionnaire()));

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
