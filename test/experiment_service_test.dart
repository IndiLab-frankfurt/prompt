// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/extensions.dart';

LocalDatabaseService mockLocalDatabaseService = LocalDatabaseService.db;
SettingsService mockSettingsService = SettingsService();
ApiService apiService = ApiService(mockSettingsService);
DataService mockDataService = DataService(apiService, mockSettingsService);
UserService mockUserService = UserService(mockSettingsService, mockDataService);
LoggingService mockLoggingService = LoggingService(mockDataService);
NotificationService mockNotificationService = NotificationService();
RewardService mockRewardService =
    RewardService(mockDataService, mockLoggingService);
NavigationService mockNavigationService = NavigationService();

void main() {
  test('Experiment Service should schedule days', () {
    // Verify that our counter has incremented.
    // expService.schedulePrompts(1);
    int getDaysSinceStart(DateTime regDate) {
      var compareDate =
          DateTime(regDate.year, regDate.month, regDate.day, 3, 0, 0);
      var daysAgo = compareDate.daysAgo();
      return daysAgo;
    }

    var now = DateTime.now();
    now = now.subtract(Duration(days: 1));
    var lateRegDay = DateTime(now.year, now.month, now.day, 23, 20);
    var oneDayAgo = getDaysSinceStart(lateRegDay);
    expect(oneDayAgo, 1);

    now = DateTime.now();
    now = now.subtract(Duration(days: 5));
    var lateRegDay2 = DateTime(now.year, now.month, now.day, 23, 20);
    var twoDaysAgo = getDaysSinceStart(lateRegDay2);
    expect(twoDaysAgo, 5);

    now = DateTime.now();
    var regToday = DateTime(now.year, now.month, now.day, 02, 0);
    var today = getDaysSinceStart(regToday);
    expect(today, 0);
  });
}
