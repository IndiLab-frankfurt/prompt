import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SettingsKeys {
  static const String username = "userid";
  static const String email = "email";
  static const String password = "";
  static const String accessToken = "accessToken";
  static const String refreshToken = "refreshToken";
  static const String timerDurationInSeconds = "timerDurationInSeconds";
  static const String initSessionStep = "initSessionStep";
  static const String backGroundImage = "backgroundImage";
  static const String backgroundColors = "backgroundColors";
}

class SettingsService {
  // LocalDatabaseService _databaseService;

  final storage = new FlutterSecureStorage();

  Map<String, String> _settingsCache = {
    SettingsKeys.accessToken: "",
    SettingsKeys.username: "",
    SettingsKeys.email: "",
    SettingsKeys.password: "",
    SettingsKeys.refreshToken: "",
    SettingsKeys.timerDurationInSeconds: "1500",
    SettingsKeys.initSessionStep: "0",
    SettingsKeys.backGroundImage: "",
    SettingsKeys.backgroundColors: "ffff55,ffff55"
  };

  SettingsService();

  Future<bool> initialize() async {
    // iterate over all keys from _settingsCache and read them from secure storage.
    // We are using the explicit method, because readAll() does not work on all platforms
    for (var key in _settingsCache.keys) {
      var value = await storage.read(key: key);
      _settingsCache[key] = value ?? _settingsCache[key]!;
    }

    return true;
  }

  getSettingUncached(String key) async {
    var settingsValue = await storage.read(key: key);
    return settingsValue;
  }

  getSetting(String setting) {
    return _settingsCache[setting];
  }

  setSetting(String setting, String value) async {
    await this.storage.write(key: setting, value: value);
    _settingsCache[setting] = value;
  }

  deleteSetting(String setting) async {
    await this.storage.delete(key: setting);
    _settingsCache.remove(setting);
  }
}
