import 'dart:async';
import 'dart:core';

import 'package:shared_preferences/shared_preferences.dart';

class UserSimplePreferences{
  static const _keyUserName = 'userName';
  static const _keyUserEmail = 'userEmail';
  static const _keyUserAbout = 'userAbout';
  static SharedPreferences _preferences;
  static Future init () async =>
      _preferences = await SharedPreferences.getInstance();
  static Future setUserName(String userName) async =>
      await _preferences.setString(_keyUserName, userName);
  static String getUserName() => _preferences.getString(_keyUserName);

  static Future  setUserEmail(String userEmail) async =>
      await _preferences.setString(_keyUserEmail, userEmail);
  static String getUserEmail() => _preferences.getString(_keyUserEmail);

  static Future  setUserAbout(String userAbout) async =>
      await _preferences.setString(_keyUserAbout, userAbout);
  static String getUserAbout() => _preferences.getString(_keyUserAbout);


}