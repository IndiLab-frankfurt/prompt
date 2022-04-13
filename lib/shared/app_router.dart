import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/about_screen.dart';
import 'package:prompt/screens/about_video_screen.dart';
import 'package:prompt/screens/assessments/disributed_learning_video_screen.dart';
import 'package:prompt/screens/auth/random_user_login_screen.dart';
import 'package:prompt/screens/change_mascot_screen.dart';
import 'package:prompt/screens/auth/login_screen.dart';
import 'package:prompt/screens/dashboard_screen.dart';
import 'package:prompt/screens/auth/registration_screen.dart';
import 'package:prompt/screens/learning_tips_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/session_zero/session_zero_screen.dart';
import 'package:prompt/screens/study_complete_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/change_mascot_view_model.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/viewmodels/random_user_login_view_model.dart';
import 'package:prompt/viewmodels/registration_view_model.dart';
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

      case RouteNames.REGISTER:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<RegistrationViewModel>(
                create: (_) => RegistrationViewModel(locator.get<UserService>(),
                    locator.get<NavigationService>()),
                child: RegistrationScreen(
                  backgroundColor1: Color(0xFFFFF3E0),
                  backgroundColor2: Color(0xFFFFF3E0),
                  highlightColor: Colors.blue,
                  foregroundColor: Color(0xFFFFF3E0),
                )));

      case RouteNames.RANDOM_LOGIN:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => RandomUserLoginViewModel(
                    locator.get<UserService>(),
                    locator.get<NavigationService>()),
                child: RandomUserLoginScreen()));

      case RouteNames.NO_TASKS:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  create: (_) => DashboardViewModel(
                      locator.get<ExperimentService>(),
                      locator.get<DataService>(),
                      locator.get<NavigationService>()),
                  child: DashboardScreen(),
                ));

      case RouteNames.SESSION_ZERO:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => SessionZeroViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>(),
                    locator.get<RewardService>()),
                child: SessionZeroScreen()));

      case RouteNames.MASCOT_CHANGE:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => ChangeMascotViewModel(
                    locator.get<RewardService>(), locator.get<DataService>()),
                child: ChangeMascotScreen()));

      case RouteNames.REWARD_SELECTION:
        return MaterialPageRoute(builder: (_) => RewardSelectionScreen());

      case RouteNames.VIDEO_DISTRIBUTED_LEARNING:
        return MaterialPageRoute(builder: (_) => DistributedLearningVideo());

      case RouteNames.ABOUT_PROMPT:
        return MaterialPageRoute(builder: (_) => AboutScreen());

      case RouteNames.ABOUT_PROMPT_VIDEO:
        return MaterialPageRoute(builder: (_) => AboutVideoScreen());

      case RouteNames.STUDY_COMPLETE:
        return MaterialPageRoute(builder: (_) => StudyCompleteScreen());

      case RouteNames.LEARNING_TIPS:
        return MaterialPageRoute(builder: (_) => LearningTipsScreen());

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
