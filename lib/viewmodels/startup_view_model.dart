import 'package:prompt/services/locator.dart';
import 'package:prompt/services/api_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/navigation_service.dart';
import 'package:prompt/services/notification_service.dart';
import 'package:prompt/services/push_notification_service.dart';
import 'package:prompt/services/reward_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/services/study_service.dart';
import 'package:prompt/services/user_service.dart';
import 'package:prompt/viewmodels/base_view_model.dart';
import 'package:prompt/shared/enums.dart';

class StartupViewModel extends BaseViewModel {
  List<String> debugTexts = [];

  StartupViewModel() {
    print("Startup");
    Future.delayed(Duration.zero).then((v) async {
      var appStartupMode = await initialize();
      startApp(appStartupMode);
    });
  }

  /*
   * Navigate with replacement to prevent back navigation to the splash screen
   */
  Future<void> startApp(AppStartupMode appStartupMode) async {
    print("Navigating to ${appStartupMode.toString()}");
    var nav = locator<NavigationService>();

    switch (appStartupMode) {
      case AppStartupMode.normal:
        nav.navigateAndRemove(AppScreen.Mainscreen);
        break;
      case AppStartupMode.signin:
        nav.navigateAndRemove(AppScreen.Login);
        break;
      case AppStartupMode.firstLaunch:
        nav.navigateAndRemove(AppScreen.Login);
        break;
      case AppStartupMode.noTasks:
        // nav.navigateAndRemove(AppScreen.Mainscreen);
        await locator<StudyService>()
            .nextScreenForScreenName(AppScreen.Mainscreen.name);
        break;
    }
  }

  addDebugText(String text) {
    this.debugTexts.add(text);
    notifyListeners();
  }

  Future<AppStartupMode> initialize() async {
    await locator<SettingsService>().initialize();

    await locator<ApiService>().initialize();

    await locator<PushNotificationService>().initialize();

    bool userInitialized = await locator<UserService>().initialize();

    bool signedIn = await locator<UserService>().isSignedIn();
    if (!userInitialized || !signedIn) {
      return AppStartupMode.firstLaunch;
    }

    await locator<NotificationService>().initialize();

    await locator<RewardService>().initialize();

    var userData = await locator<DataService>().getUserData();
    if (userData == null) {
      return AppStartupMode.firstLaunch;
    }

    return AppStartupMode.noTasks;
  }
}
