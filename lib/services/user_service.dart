import 'dart:math';
import 'package:package_info/package_info.dart';
import 'package:prompt/locator.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';

class UserService {
  UserService(this._settings, this._dataService);

  final SettingsService _settings;
  final DataService _dataService;
  String userId = "";
  bool _isSignedIn = false;

  Future<bool> initialize() async {
    // await _settings.getSetting(SettingsKeys.userId).then((value) {
    //   userId = value;
    //   _isSignedIn = value.isnotNullOrEmpty;
    // });

    var id = getUsername();
    if (id.isEmpty) return false;
    return true;
  }

  saveUsername(String username) async {
    await _settings.setSetting(SettingsKeys.username, username);
  }

  int _generateGroupNumber() {
    var rng = new Random();
    return rng.nextInt(ExperimentService.NUM_GROUPS) + 1;
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
        initSessionStep: 0,
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
    // if (user != null) {
    //   await saveUsername(email);
    //   var userData = await FirebaseService().getUserData(email);
    //   if (userData == null) {
    //     userData = await getDefaultUserData(email, uid: user.uid);
    //     await FirebaseService().insertUserData(userData);
    //   }
    //   locator<DataService>().setUserDataCache(userData);
    //   return userData;
    // } else {
    //   return null;
    // }
  }

  _getRandomUsername() {
    var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 12; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
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
