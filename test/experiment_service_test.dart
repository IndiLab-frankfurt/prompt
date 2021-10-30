// This is a basic Flutter widget test.
//
import 'package:flutter_test/flutter_test.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/shared/extensions.dart';

import 'mocks/mock_firebase_service.dart';

IDatabaseService mockFirebaseService = MockFirebaseService();
LocalDatabaseService mockLocalDatabaseService = LocalDatabaseService.db;
SettingsService mockSettingsService = SettingsService(mockLocalDatabaseService);
UserService mockUserService =
    UserService(mockSettingsService, mockFirebaseService);
DataService mockDataService = DataService(mockFirebaseService, mockUserService,
    mockLocalDatabaseService, mockSettingsService);
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
