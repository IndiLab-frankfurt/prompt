import 'package:flutter/material.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/about_screen.dart';
import 'package:prompt/screens/auth/random_user_login_screen.dart';
import 'package:prompt/screens/change_mascot_screen.dart';
import 'package:prompt/screens/auth/login_screen.dart';
import 'package:prompt/screens/dashboard_screen.dart';
import 'package:prompt/screens/auth/registration_screen.dart';
import 'package:prompt/screens/learning_tips_screen.dart';
import 'package:prompt/screens/main/distributed_learning_screens.dart';
import 'package:prompt/screens/main/learning_tip_screens.dart';
import 'package:prompt/screens/main/learning_tricks_overview.dart';
import 'package:prompt/screens/main/mental_contrasting_screens.dart';
import 'package:prompt/screens/main/plan_edit_screen.dart';
import 'package:prompt/screens/main/plan_reminder_screens.dart';
import 'package:prompt/screens/main/video_create_plan_screen.dart';
import 'package:prompt/screens/rewards/reward_selection_screen.dart';
import 'package:prompt/screens/session_zero/session_zero_screen.dart';
import 'package:prompt/screens/session_zero/vocab_learn_timing_screen.dart';
import 'package:prompt/screens/study_complete_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/change_mascot_view_model.dart';
import 'package:prompt/viewmodels/distributed_learning_view_model.dart';
import 'package:prompt/viewmodels/learning_tip_view_model.dart';
import 'package:prompt/viewmodels/learning_tricks_overview_view_model.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
import 'package:prompt/viewmodels/dashboard_view_model.dart';
import 'package:prompt/viewmodels/mental_contrasting_view_model.dart';
import 'package:prompt/viewmodels/plan_edit_view_model.dart';
import 'package:prompt/viewmodels/plan_reminder_view_model.dart';
import 'package:prompt/viewmodels/random_user_login_view_model.dart';
import 'package:prompt/viewmodels/registration_view_model.dart';
import 'package:prompt/viewmodels/session_zero_view_model.dart';
import 'package:prompt/viewmodels/vocab_learn_timing_view_model.dart';
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
                      locator.get<RewardService>()),
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

      case RouteNames.DISTRIBUTED_LEARNING:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: DistributedLearningScreens(),
                  create: (_) => DistributedLearningViewModel(
                      locator.get<DataService>(),
                      locator.get<ExperimentService>()),
                ));

      case RouteNames.MENTAL_CONTRASTING:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: MentalContrastingScreens(),
                  create: (_) => MentalContrastingViewModel(
                      locator.get<DataService>(),
                      locator.get<ExperimentService>()),
                ));

      case RouteNames.PLAN_REMINDER:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: PlanReminderScreens(),
                  create: (_) => PlanReminderViewModel(
                      locator.get<DataService>(),
                      locator.get<ExperimentService>()),
                ));

      case RouteNames.SINGLE_LEARNING_TIP:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: LearningTipScreens(),
                  create: (_) => LearningTipViewModel(
                      locator.get<ExperimentService>(),
                      locator.get<DataService>()),
                ));

      case RouteNames.ABOUT_PROMPT:
        return MaterialPageRoute(builder: (_) => AboutScreen());

      case RouteNames.STUDY_COMPLETE:
        return MaterialPageRoute(builder: (_) => StudyCompleteScreen());

      case RouteNames.LEARNING_TIPS:
        return MaterialPageRoute(builder: (_) => LearningTipsScreen());

      case RouteNames.EDIT_PLAN:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                child: PlanEditScreen(),
                create: (_) => PlanEditViewModel(locator.get<DataService>(),
                    locator.get<ExperimentService>())));

      case RouteNames.CHANGE_REMINDER_TIME:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: VocabLearnTimingScreen(),
                  create: (_) => VocabLearnTimingViewModel(
                      locator.get<DataService>(),
                      locator.get<NotificationService>()),
                ));

      case RouteNames.LEARNING_TRICKS_OVERVIEW:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                  child: LearningTricksOverviewScreen(),
                  create: (_) => LearningTricksOverviewViewModel(
                      locator.get<DataService>(),
                      locator.get<ExperimentService>()),
                ));

      case RouteNames.VIDEO_CREATEPLAN:
        return MaterialPageRoute(builder: (_) => VideoCreatePlanScreen());

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
