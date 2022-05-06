import 'dart:math';
import 'package:prompt/locator.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:prompt/models/user_data.dart';
import 'package:prompt/services/data_service.dart';
import 'package:prompt/services/experiment_service.dart';
import 'package:prompt/services/firebase_service.dart';
import 'package:prompt/services/i_database_service.dart';
import 'package:prompt/services/settings_service.dart';
import 'package:prompt/shared/enums.dart';

class UserService {
  UserService(this._settings, this._databaseService) {
    _databaseService.getCurrentUser()!.listen((user) {
      _isSignedIn = user != null;
    });
  }

  final SettingsService _settings;
  final IDatabaseService _databaseService;
  String userId = "";
  bool _isSignedIn = false;

  Future<bool> initialize() async {
    var id = getUsername();
    if (id.isEmpty) return false;
    return true;
  }

  Future<bool> isNameAvailable(String userId) async {
    return await FirebaseService().isNameAvailable(userId);
  }

  saveUsername(String username) async {
    await _settings.setSetting(SettingsKeys.userId, username);
  }

  int _generateGroupNumber() {
    var rng = new Random();
    return rng.nextInt(ExperimentService.NUM_GROUPS) + 1;
  }

  Future<String> registerUser(String email, String password) async {
    var treatmentGroup = _generateGroupNumber();
    await FirebaseService().registerUser(email, password, treatmentGroup);
    await saveUsername(email);
    return RegistrationCodes.SUCCESS;
  }

  static int getGroup() {
    var rng = Random();
    var isControlGroup = rng.nextInt(2);
    if (isControlGroup == 1) {
      return 1;
    } else {
      var condition = rng.nextInt(5);
      condition += 2;
      return condition;
    }
  }

  static Future<UserData> getDefaultUserData(user, {uid = ""}) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    String appVersion = "v.$version+$buildNumber";

    return UserData(
        firebaseId: uid,
        user: user,
        group: 1,
        score: 0,
        streakDays: 0,
        initSessionStep: 0,
        appVersion: appVersion,
        registrationDate: DateTime.now());
  }

  Future<UserData?> signInUser(String email, String password) async {
    var user = await FirebaseService().signInUser(email, password);
    if (user != null) {
      await saveUsername(email);
      var userData = await FirebaseService().getUserData(email);
      if (userData == null) {
        userData = await getDefaultUserData(email, uid: user.uid);
        await FirebaseService().insertUserData(userData);
      }
      locator<DataService>().setUserDataCache(userData);
      return userData;
    } else {
      return null;
    }
  }

  saveRandomUser() async {
    var uid = _getRandomUsername();
    return registerUser("$uid@prompt.studie", "123456");
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
    return _settings.getSetting(SettingsKeys.userId);
  }

  bool isSignedIn() {
    return _isSignedIn;
  }
}
