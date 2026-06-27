import 'package:shared_preferences/shared_preferences.dart';

class ThemePrefs {
  static const String key = 'theme_mode';

  Future<void> saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, isDark);
  }

  Future<bool> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false; // false = light mode by default
  }
}
