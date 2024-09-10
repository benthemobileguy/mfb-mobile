import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/profile/data/client/profile_api_client.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
import 'package:tampay_mobile/app/profile/domain/repository/profile_repository.dart';
import 'package:tampay_mobile/main.dart';
import 'package:tampay_mobile/manager/auth_manager.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiClient _profileApiClient;

  ProfileRepositoryImpl(this._profileApiClient);

  @override
  Future<UserProfile> getProfile() async {
    print("Sdmskldmksd");
    print( "Bearer ${getIt<AuthManager>().token!}");
    try {
      final userProfile = await _profileApiClient.getUserProfile(
          "Bearer ${getIt<AuthManager>().token!}",
          accessKey: Env.accessKey,
          secretKey: Env.secretKey);
      return userProfile;
    } catch (e) {
      throw Exception(e);
    }
  }
}
