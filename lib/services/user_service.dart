import 'dart:math';
import 'package:package_info/package_info.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/settings_service.dart';

class UserService {
  UserService(this._settings, this._dataService);

  final SettingsService _settings;
  final DataService _dataService;
  String userId = "";
  bool _isSignedIn = false;

  Future<bool> initialize() async {
    var id = getUsername();
    if (id.isEmpty) return false;
    _isSignedIn = true;
    return true;
  }

  saveUsername(String username) async {
    await _settings.setSetting(SettingsKeys.username, username);
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

  static Future<UserData> getDefaultUserData(user, {uid = ""}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String appVersion = "v.$version+$buildNumber";

    var group = getGroup();
    var cabuuCode = "123";

    return UserData(
        user: user,
        group: group,
        cabuuCode: cabuuCode,
        score: 0,
        streakDays: 0,
        initStep: 0,
        appVersion: appVersion,
        registrationDate: DateTime.now());
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

    // obtain the user data
    var userData = await _dataService.getUserData();

    return userData;
  }

  String getUsername() {
    var userid = _settings.getSetting(SettingsKeys.username);
    if (userid == null) return "";
    return userid;
  }

  bool isSignedIn() {
    return _isSignedIn;
  }
}
