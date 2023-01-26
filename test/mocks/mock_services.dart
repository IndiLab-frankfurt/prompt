import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';

LocalDatabaseService mockLocalDatabaseService = LocalDatabaseService.db;
SettingsService mockSettingsService = SettingsService();
IDatabaseService apiService = ApiService(mockSettingsService);
DataService mockDataService = DataService(apiService, mockSettingsService);
UserService mockUserService = UserService(mockSettingsService, mockDataService);
LoggingService mockLoggingService = LoggingService(mockDataService);
NotificationService mockNotificationService = NotificationService();
RewardService mockRewardService =
    RewardService(mockDataService, mockLoggingService);
NavigationService mockNavigationService = NavigationService();

StudyService mockExperimentService = StudyService(
    mockDataService,
    mockNotificationService,
    mockLoggingService,
    mockRewardService,
    mockNavigationService);

Future<SettingsService> getMockSettingsService() async {
  var settingsService = SettingsService();
  await settingsService.setSetting(SettingsKeys.username, "123456");
  await settingsService.setSetting(SettingsKeys.password, "Prompt1234");
  return mockSettingsService;
}

Future<ApiService> getMockApiService() async {
  var settingsService = await getMockSettingsService();
  return ApiService(settingsService);
}
