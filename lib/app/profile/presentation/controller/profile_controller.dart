import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  UserProfile? userProfile;

  ProfileController(this.ref);

  Future<UserProfile?> getProfile() async {
    try {
      // Fetch the profile from the service
      final UserProfile result =
          await ref.read(profileServiceProvider).getProfile();

      getIt<AuthManager>().saveUser(result); // Save the profile for persistence

      // Assign the result to the profile
      userProfile = result;

      // Ensure that the UI is notified about the updated profile
      notifyListeners();

      return userProfile;
    } catch (e) {
      debugPrint("Error fetching profile: $e");
      return null;
    }
  }
}
