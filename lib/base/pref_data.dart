import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final localStorageProvider = Provider<PrefData>((ref) {
  return PrefData();
});

class PrefData {
  static const user = "user";
  static String isCode = "isCode";
  static String onboardingCompletedKey = "onboardingCompletedKey";
  static String introAvailable = "isIntroAvailable";
  static String isLoggedInKey = "isLoggedIn";

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
  }

  Future<void> saveJsonData(String key, Object? object) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(object);
    prefs.setString(key, data);
  }

  Future<void> setStringValue(String name, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, value);
  }

  dynamic getJsonData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(key);
    try {
      return jsonDecode(data ?? '');
    } catch (e) {
      return null;
    }
  }

  Future<String?> getStringValue(name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? persitValue = prefs.getString(name);
    return persitValue;
  }

  static setLogIn(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(isLoggedInKey, avail);
  }

  static setIsOnboardingCompleted(bool avail) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(onboardingCompletedKey, avail);
  }

  static Future<bool> getIsOnboardingCompleted() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isOnboardingCompleted =
        preferences.getBool(onboardingCompletedKey) ?? false;
    return isOnboardingCompleted;
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isLogIn = preferences.getBool(isLoggedInKey) ?? false;
    return isLogIn;
  }

  Future<void> removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static setIntro(bool code) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(introAvailable, code);
  }

  static Future<bool> getIntro() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isCodeAvailable = preferences.getBool(introAvailable) ?? true;
    return isCodeAvailable;
  }

  Future<void> logOut() async {
    SharedPreferences prefs = await PrefData.getPrefInstance();

    // Clear user-specific data
    await prefs.remove(PrefData.user);
    await prefs.remove(PrefData.isLoggedInKey);
    await prefs.remove(PrefData.onboardingCompletedKey);
    await prefs.remove(PrefData.introAvailable);
  }
}
