import 'package:tampay_mobile/app/login/domain/model/response/login_response.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/base/pref_data.dart';

class AuthManager {
  LoginResponse? _authDetails;
  String? get token => _authDetails?.data?.tokens?[0].accessToken;
  static bool isLoggedIn = false;
  PrefData prefData = PrefData();

  // Key for storing auth details
  static const String authDetailsKey = 'auth_details';

  /// Authenticate user and persist the auth details
  void authenticateUser(LoginResponse? authDetails) {
    if (authDetails != null) {
      isLoggedIn = true;
      _authDetails = authDetails;

      // Persist auth details
      _saveAuthDetails(authDetails);
    }
  }

  /// Retrieve the logged-in user profile from storage
  Future<UserProfile?> getLoggedInUser() async {
    Map<String, dynamic>? userDetails =
        await prefData.getJsonData(PrefData.user) as Map<String, dynamic>?;

    if (userDetails != null) {
      UserProfile userResponse = UserProfile.fromJson(userDetails);
      return userResponse;
    }
    return null;
  }

  /// Save the user profile to persistent storage
  Future<void> saveUser(UserProfile userResponse) async {
    return prefData.saveJsonData(PrefData.user, userResponse.toJson());
  }

  /// Save auth details (LoginResponse) to persistent storage
  Future<void> _saveAuthDetails(LoginResponse authDetails) async {
    await prefData.saveJsonData(authDetailsKey, authDetails.toJson());
  }

  /// Load persisted auth details on app startup
  Future<void> loadAuthDetails() async {
    Map<String, dynamic>? authDetailsJson =
        await prefData.getJsonData(authDetailsKey) as Map<String, dynamic>?;
    if (authDetailsJson != null) {
      _authDetails = LoginResponse.fromJson(authDetailsJson);
      isLoggedIn = true; // Set the logged-in status
    } else {
      isLoggedIn = false;
    }
  }

  /// Clear auth details when logging out
  Future<void> clearAuthDetails() async {
    _authDetails = null;
    isLoggedIn = false;
    await prefData.removeData(authDetailsKey);
    await prefData.removeData(PrefData.user);
  }
}
