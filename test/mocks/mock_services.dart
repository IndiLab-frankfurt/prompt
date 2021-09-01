import 'package:firebase_core/firebase_core.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';

import 'mock_firebase_service.dart';

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

ExperimentService mockExperimentService = ExperimentService(
    mockDataService,
    mockNotificationService,
    mockLoggingService,
    mockRewardService,
    mockNavigationService);
