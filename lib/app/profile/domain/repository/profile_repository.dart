import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';

import '../../../../base/dio_provider.dart';
import '../../data/client/profile_api_client.dart';
import '../../data/remote/profile_repository_impl.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ProfileApiClient(
    baseUrl: ref.read(dioProvider).options.baseUrl,
    ref.read(dioProvider),
  ));
});

abstract class ProfileRepository {
  Future<UserProfile> getProfile();
}
