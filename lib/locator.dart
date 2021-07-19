import 'package:get_it/get_it.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/firebase_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<NavigationService>(NavigationService());

  locator.registerSingleton<LocalDatabaseService>(LocalDatabaseService.db);

  locator.registerSingleton<FirebaseService>(FirebaseService());

  locator.registerSingleton<SettingsService>(
      SettingsService(locator.get<LocalDatabaseService>()));

  locator.registerSingleton<UserService>(
      UserService(locator.get<SettingsService>()));

  locator.registerSingleton<DataService>(DataService(
      locator.get<FirebaseService>(),
      locator.get<UserService>(),
      locator.get<LocalDatabaseService>(),
      locator.get<SettingsService>()));

  locator.registerSingleton<LoggingService>(
      LoggingService(locator.get<DataService>()));

  locator.registerSingleton<NotificationService>(NotificationService());

  locator.registerSingleton<RewardService>(
      RewardService(locator.get<DataService>(), locator.get<LoggingService>()));

  locator.registerSingleton<ExperimentService>(ExperimentService(
      locator.get<DataService>(),
      locator.get<NotificationService>(),
      locator.get<LoggingService>(),
      locator.get<RewardService>(),
      locator.get<NavigationService>()));
}
