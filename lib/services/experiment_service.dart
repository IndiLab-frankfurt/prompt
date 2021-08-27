import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/shared/route_names.dart';

class ExperimentService {
  static const int NUM_GROUPS = 4;
  static const Duration MAX_STUDY_DURATION = Duration(days: 50);

  final DataService _dataService;
  final NotificationService _notificationService;
  final LoggingService _loggingService;
  final RewardService _rewardService;
  final NavigationService _navigationService;

  ExperimentService(this._dataService, this._notificationService,
      this._loggingService, this._rewardService, this._navigationService);

  nextScreen(String currentScreen) async {
    if (currentScreen == RouteNames.SESSION_ZERO ||
        currentScreen == RouteNames.ASSESSMENT_EVENING ||
        currentScreen == RouteNames.ASSESSMENT_MORNING) {
      return await _navigationService.navigateTo(RouteNames.NO_TASKS);
    }
  }
}
