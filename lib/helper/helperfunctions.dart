import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String sharedPreferanceUserLoggedInKey = "ISLOGGEDIN";
  static String sharedPreferenceUserNameKey = "USERNAMEKEY";
  static String sharedPreferenceUserEmailKey = "USEREMAILKEY";

  //saving data to Shared Preference

  static Future<bool> saveUserLoggedInSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferanceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  // getting data from shared Preference

  static Future<bool> getUserLoggedInSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferanceUserLoggedInKey);
  }

  static Future<String> getUserUserNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserNameKey);
  }

  static Future<String> getUserUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }
}
