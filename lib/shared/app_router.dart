import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/screens/login_screen.dart';
import 'package:prompt/screens/no_task_screen.dart';
import 'package:prompt/screens/session_zero/session_zero_screen.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/route_names.dart';
import 'package:prompt/viewmodels/login_view_model.dart';
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
        return MaterialPageRoute(builder: (_) => NoTasksScreen());

      case RouteNames.SESSION_ZERO:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => SessionZeroViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>()),
                child: SessionZeroScreen()));

      case RouteNames.REMINDER_DEFAULT:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider(
                create: (_) => SessionZeroViewModel(
                    locator.get<ExperimentService>(),
                    locator.get<DataService>()),
                child: SessionZeroScreen()));

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
