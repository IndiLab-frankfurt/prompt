import 'package:prompt/services/local_database_service.dart';
import 'package:prompt/shared/enums.dart';

class SettingsService {
  // SharedPreferences _prefs;
  LocalDatabaseService _databaseService;

  Map<String, String> _settingsCache = {
    SettingsKeys.userId: "",
    SettingsKeys.email: "",
    SettingsKeys.timerDurationInSeconds: "1500",
    SettingsKeys.initSessionStep: "0",
    SettingsKeys.backGroundImage: "",
    SettingsKeys.backgroundColors: "ffffff,ffffff"
  };

  SettingsService(this._databaseService);

  Future<bool> initialize() async {
    // return SharedPreferences.getInstance().then((prefs) {
    //   _prefs = prefs;
    //   return true;
    // }).catchError((error) {
    //   return false;
    // });
    var settings = await _databaseService.getAllSettings();
    for (var setting in settings) {
      print("Setting from db is $setting");
      _settingsCache[setting["key"]] = setting["value"].toString();
    }
    return true;
  }

  getSetting(String setting) {
    return _settingsCache[setting];
  }

  setSetting(String setting, String value) async {
    await this
        ._databaseService
        .upsertSetting(setting, value); //_prefs.setString(setting, value);
    _settingsCache[setting] = value;
  }

  deleteSetting(String setting) async {
    await this._databaseService.deleteSetting(setting);
    _settingsCache.remove(setting);
  }
}
