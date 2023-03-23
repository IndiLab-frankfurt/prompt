import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:prompt/shared/enums.dart';

class SettingsService {
  static const Map<SettingsKeys, String> DEFAULT_VALUES = {
    SettingsKeys.accessToken: "",
    SettingsKeys.username: "",
    SettingsKeys.email: "",
    SettingsKeys.password: "",
    SettingsKeys.refreshToken: "",
    SettingsKeys.backGroundImage: "",
    SettingsKeys.backgroundColors: "ffff55,ffff55",
    SettingsKeys.apiBaseUrl: "https://prompt-app.eu",
  };

  final storage = new FlutterSecureStorage();

  Map<SettingsKeys, String> _settingsCache = DEFAULT_VALUES;

  SettingsService();

  Future<bool> initialize() async {
    // iterate over all keys from _settingsCache and read them from secure storage.
    // We are using the explicit method, because readAll() does not work on all platforms
    for (var key in _settingsCache.keys) {
      var value = await storage.read(key: key.name);
      _settingsCache[key] = value ?? _settingsCache[key]!;
    }

    return true;
  }

  getSettingUncached(String key) async {
    var settingsValue = await storage.read(key: key);
    return settingsValue;
  }

  getSetting(SettingsKeys setting) {
    return _settingsCache[setting];
  }

  setSetting(SettingsKeys key, String value) async {
    try {
      await this.storage.write(key: key.name, value: value);
      _settingsCache[key] = value;
    } catch (e) {
      throw Exception("Invalid setting key");
    }
  }

  Future<void> deleteSetting(SettingsKeys setting) async {
    await this.storage.delete(key: setting.name);
    _settingsCache.remove(setting);
  }

  Future<void> deleteAllSettings() async {
    await this.storage.deleteAll();
    _settingsCache = DEFAULT_VALUES;
  }
}
