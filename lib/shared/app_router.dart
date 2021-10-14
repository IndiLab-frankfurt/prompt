import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/about_screen.dart';
import 'package:prompt/screens/assessments/disributed_learning_video_screen.dart';
import 'package:prompt/screens/assessments/evening_assessment_screen.dart';
import 'package:prompt/screens/internalisation/daily_internalisation_screen.dart';
import 'package:prompt/screens/internalisation/default_reminder_screen.dart';
import 'package:prompt/screens/assessments/morning_assessment_screen.dart';
import 'package:prompt/screens/login_screen.dart';
import 'package:prompt/screens/no_task_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/session_zero/session_zero_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/daily_internalisation_view_model.dart';
import 'package:prompt/viewmodels/evening_assessment_view_model.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
import 'package:prompt/viewmodels/morning_assessment_view_model.dart';
import 'package:prompt/viewmodels/no_task_view_model.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    locator<LoggingService>().logEvent("navigation",
        data: {"routeName": settings.name, "routeArgs": settings.arguments});
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
                  create: (_) => NoTaskViewModel(
                      locator.get<ExperimentService>(),
                      locator.get<DataService>(),
                      locator.get<NavigationService>()),
                  child: NoTasksScreen(),
                ));

      case RouteNames.SESSION_ZERO:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => SessionZeroViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>(),
                    locator.get<RewardService>()),
                child: SessionZeroScreen()));

      case RouteNames.DAILY_INTERNALISATION:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => DailyInternalisationViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>()),
                child: DailyInternalisationScreen()));

      case RouteNames.ASSESSMENT_MORNING:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => MorningAssessmentViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>()),
                child: MorningAssessmentScreen()));

      case RouteNames.ASSESSMENT_EVENING:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => EveningAssessmentViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>()),
                child: EveningAssessmentScreen()));

      case RouteNames.REWARD_SELECTION:
        return MaterialPageRoute(builder: (_) => RewardSelectionScreen());

      case RouteNames.REMINDER_DEFAULT:
        return MaterialPageRoute(builder: (_) => DefaultReminderScreen());

      case RouteNames.VIDEO_DISTRIBUTED_LEARNING:
        return MaterialPageRoute(builder: (_) => DistributedLearningVideo());

      case RouteNames.ABOUT_PROMPT:
        return MaterialPageRoute(builder: (_) => AboutScreen());

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
