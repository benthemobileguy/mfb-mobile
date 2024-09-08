import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/main.dart';
import 'package:tampay_mobile/manager/auth_manager.dart';
import '../../services/profile_service.dart';

final profileControllerProvider =
    ChangeNotifierProvider<ProfileController>((ref) {
  return ProfileController(ref);
});

class ProfileController extends ChangeNotifier {
  final Ref ref;
  UserProfile? _userProfile;

  ProfileController(this.ref);

  Future<UserProfile> getProfile() async {
    try {
      // Call the service to get the profile
      final UserProfile result =
          await ref.read(profileServiceProvider).getProfile();
      getIt<AuthManager>().saveUser(result); // Save the user profile
      // Check if the result is a Success
      if (result is Success<UserProfile, Error>) {
        _userProfile = UserProfile.fromJson(
            result.data!.toJson()); // Access success data directly
      } else if (result is Error<UserProfile, Error>) {
        // Handle the error case
      }

      // Return the user profile or an empty/default UserProfile if failed
      return _userProfile ?? UserProfile();
    } catch (e) {
      // Handle any exceptions
      debugPrint("An exception occurred: $e");
      return UserProfile(); // Return a default UserProfile on error
    } finally {
      // Notify listeners about changes to the profile
      notifyListeners();
    }
  }
}
