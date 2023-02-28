import 'package:get_it/get_it.dart';
import 'package:prompt/models/questionnaire.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/push_notification_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/services/logging_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/viewmodels/multi_page_questionnaire_view_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  _setUpServices();
  _setUpViewModels();
}

void _setUpServices() {
  locator.registerSingleton<NavigationService>(NavigationService());

  locator.registerSingleton<LocalDatabaseService>(LocalDatabaseService.db);

  locator.registerSingleton<SettingsService>(SettingsService());

  locator.registerSingleton<PushNotificationService>(
      PushNotificationService(locator.get<SettingsService>()));

  locator.registerSingleton<ApiService>(
      ApiService(locator.get<SettingsService>()));

  locator.registerSingleton<DataService>(
      DataService(locator.get<ApiService>(), locator.get<SettingsService>()));

  locator.registerSingleton<UserService>(
      UserService(locator.get<SettingsService>(), locator.get<DataService>()));

  locator.registerSingleton<LoggingService>(
      LoggingService(locator.get<DataService>()));

  locator.registerSingleton<RewardService>(
      RewardService(locator.get<DataService>(), locator.get<LoggingService>()));

  locator.registerSingleton<NotificationService>(
      NotificationService(locator.get<LoggingService>()));

  locator.registerSingleton<StudyService>(StudyService(
      locator.get<DataService>(),
      locator.get<NotificationService>(),
      locator.get<LoggingService>(),
      locator.get<RewardService>(),
      locator.get<NavigationService>()));
}

void _setUpViewModels() {
  locator.registerFactoryParam<MultiPageQuestionnaireViewModel, Questionnaire,
          dynamic>(
      (param1, param2) => MultiPageQuestionnaireViewModel(
          locator.get<DataService>(),
          rewardService: locator.get<RewardService>(),
          studyService: locator.get<StudyService>(),
          questionnaire: param1));
}
