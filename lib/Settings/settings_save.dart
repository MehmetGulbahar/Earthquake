import 'package:shared_preferences/shared_preferences.dart';

class SettingsSave {
  static const String kandilliNotificationKey = 'kandilliNotification';
  static const String afadNotificationKey = 'afadNotification';

  static Future<bool> getKandilliNotificationEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kandilliNotificationKey) ?? false;
  }

  static Future<void> setKandilliNotificationEnabled(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(kandilliNotificationKey, value);
  }

  static Future<bool> getAfadNotificationEnabled() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(afadNotificationKey) ?? false;
  }

  static Future<void> setAfadNotificationEnabled(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(afadNotificationKey, value);
  }
}
