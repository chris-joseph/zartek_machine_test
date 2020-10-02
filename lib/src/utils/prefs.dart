import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static const String KEY_LANGUAGE = "language";
  static const String AUTH_STATUS = "auth_status";
  static const String IS_LOGGED_IN = "is_logged_in";
  static const String USER_ID = "user_id";

  static SharedPreferences sharedPrefs;

  static String getUserID() {
    return sharedPrefs.getString(AUTH_STATUS);
  }

  static void setUserID(String value) {
    sharedPrefs.setString(AUTH_STATUS, value);
  }

  static bool getAuthStatus() {
    return sharedPrefs.getBool(AUTH_STATUS);
  }

  static void setAuthStatus(bool value) {
    sharedPrefs.setBool(AUTH_STATUS, value);
  }

  static bool getIsLoggedIn() {
    return sharedPrefs.getBool(IS_LOGGED_IN);
  }

  static void setIsLoggedIn(bool value) {
    sharedPrefs.setBool(IS_LOGGED_IN, value);
  }
}
