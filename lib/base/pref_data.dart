import 'package:shared_preferences/shared_preferences.dart';

class PrefData {
  static String isCode = "isCode";
  static String onboardingCompletedKey = "onboardingCompletedKey";
  static String introAvailable = "isIntroAvailable";
  static String isLoggedInKey = "isLoggedIn";

  static Future<SharedPreferences> getPrefInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences;
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

  static setIntro(bool code) async {
    SharedPreferences preferences = await getPrefInstance();
    preferences.setBool(introAvailable, code);
  }

  static Future<bool> getIntro() async {
    SharedPreferences preferences = await getPrefInstance();
    bool isCodeAvailable = preferences.getBool(introAvailable) ?? true;
    return isCodeAvailable;
  }
}
