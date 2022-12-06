import 'package:prompt/services/local_database_service.dart';

class SettingsKeys {
  static const String userId = "userid";
  static const String email = "email";
  static const String jwtToken = "jwtToken";
  static const String timerDurationInSeconds = "timerDurationInSeconds";
  static const String initSessionStep = "initSessionStep";
  static const String backGroundImage = "backgroundImage";
  static const String backgroundColors = "backgroundColors";
}

class SettingsService {
  LocalDatabaseService _databaseService;

  Map<String, String> _settingsCache = {
    SettingsKeys.jwtToken: "",
    SettingsKeys.userId: "",
    SettingsKeys.email: "",
    SettingsKeys.timerDurationInSeconds: "1500",
    SettingsKeys.initSessionStep: "0",
    SettingsKeys.backGroundImage: "",
    SettingsKeys.backgroundColors: "ffffff,ffffff"
  };

  SettingsService(this._databaseService);

  Future<bool> initialize() async {
    var settings = await _databaseService.getAllSettings();
    for (var setting in settings) {
      print("Setting from db is $setting");
      _settingsCache[setting["key"]] = setting["value"].toString();
    }
    return true;
  }

  getSettingUncached(String key) async {
    var settingsValue = await _databaseService.getSettingsValue(key);
    return settingsValue;
  }

  getSetting(String setting) {
    return _settingsCache[setting];
  }

  getInitSessionStep() {
    return int.parse(_settingsCache[SettingsKeys.initSessionStep]!);
  }

  setSetting(String setting, String value) async {
    await this._databaseService.upsertSetting(setting, value);
    _settingsCache[setting] = value;
  }

  deleteSetting(String setting) async {
    await this._databaseService.deleteSetting(setting);
    _settingsCache.remove(setting);
  }
}
