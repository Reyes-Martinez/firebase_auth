import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static late SharedPreferences _preferences;

  static String _userUid = "";
  static bool _showOnboradin = true;
  static String _theme = "";

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get user {
    return _preferences.getString('user') ?? _userUid;
  }

  static set user(String user) {
    _userUid = user;
    _preferences.setString('user', _userUid);
  }

  static set showOnboardin(bool show) {
    _showOnboradin = show;
    _preferences.setBool('showOnboarding', _showOnboradin);
  }

  static bool get showOnboardin {
    return _preferences.getBool('showOnboarding') ?? _showOnboradin;
  }

  static String get theme {
    return _preferences.getString('theme') ?? _theme;
  }

  static set theme(String theme) {
    _theme = theme;
    _preferences.setString('theme', _theme);
  }
}
