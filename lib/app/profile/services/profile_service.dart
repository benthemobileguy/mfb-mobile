import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/domain/repository/profile_repository.dart';

// Define a provider for the ProfileService
final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileServiceImpl(
      ref.read(profileRepositoryProvider)); // Pass the reader method from Ref
});

// Abstract ProfileService class
abstract class ProfileService {
  Future<UserProfile> getProfile();
}

// Implementation of ProfileService
class ProfileServiceImpl implements ProfileService {
  final ProfileRepository _profileRepository;
  ProfileServiceImpl(this._profileRepository);

  // Implement the getProfile method
  @override
  Future<UserProfile> getProfile() async {
    try {
      // Call the service to get the profile
      final UserProfile profile = await _profileRepository.getProfile();
      // Return the fetched profile
      return profile;
    } catch (e) {
      // Handle errors by logging and throwing a custom exception
      debugPrint('Error getting profile: $e');
      throw Exception('Failed to load profile');
    }
  }
}
