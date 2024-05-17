import 'package:shared_preferences/shared_preferences.dart';

import 'settings.dart';

class SettingsRepository implements SettingsRepositoryInterface {
  final SharedPreferences pref;

  static const _isDarkThemeSelectedKey = 'dark_theme_selected';

  SettingsRepository({required this.pref});

  @override
  bool isDarkThemeSelected() {
    final seleted = pref.getBool(_isDarkThemeSelectedKey);
    return seleted ?? false;
  }

  @override
  Future<void> setDarkThemeSelected(bool selected) async {
    await pref.setBool(_isDarkThemeSelectedKey, selected);
  }
}
