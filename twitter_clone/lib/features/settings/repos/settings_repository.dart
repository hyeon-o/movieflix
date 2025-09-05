import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {

  static const String _darkModeKey = 'darkMode';

  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  Future<void> setDarkMode(bool value) async {
    await _prefs.setBool(_darkModeKey, value);
  }

  bool getDarkMode() {
    return _prefs.getBool(_darkModeKey) ?? false;
  }
}