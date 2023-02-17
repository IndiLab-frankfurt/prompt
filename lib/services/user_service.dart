import 'dart:math';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/base_service.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';

class UserService implements BaseService {
  UserService(this._settings, this._dataService);

  final SettingsService _settings;
  final DataService _dataService;
  bool _isSignedIn = false;

  @override
  Future<bool> initialize() async {
    return true;
  }

  static String getGroup() {
    var rng = Random();
    var isControlGroup = rng.nextInt(2);
    if (isControlGroup == 1) {
      return "1";
    } else {
      var condition = rng.nextInt(5);
      condition += 2;
      return condition.toString();
    }
  }

  Future<UserData?> signInUser(String email, String password) async {
    var response = await _dataService.signInUser(email, password);

    if (response == null) {
      return null;
    }

    // save all the user credential stuff
    List<Future> futures = [
      _settings.setSetting(SettingsKeys.accessToken, response.accessToken),
      _settings.setSetting(SettingsKeys.refreshToken, response.accessToken),
      _settings.setSetting(SettingsKeys.username, email),
      _settings.setSetting(SettingsKeys.password, password)
    ];

    await Future.wait(futures);

    // obtain the initial user data
    var userData = await _dataService.getUserData();

    // store the fcm key if it exists
    var fcmKey = await _settings.getSetting(SettingsKeys.fcmToken);
    if (fcmKey != null) {
      await _dataService.saveUserDataProperty("fcm_key", fcmKey);
    }

    return userData;
  }

  Future<void> firstSignIn() async {}

  String getUsername() {
    var userid = _settings.getSetting(SettingsKeys.username);
    if (userid == null) return "";
    return userid;
  }

  Future<bool> isSignedIn() async {
    var id = getUsername();
    return id.isNotEmpty;
  }
}
