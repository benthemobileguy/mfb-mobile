import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tampay_mobile/app/profile/domain/model/response/user_profile.dart';
part 'profile_api_client.g.dart';

@RestApi()
abstract class ProfileApiClient {
  factory ProfileApiClient(Dio dio, {String baseUrl}) = _ProfileApiClient;

  @GET("api/v1/profiles/me")
  Future<UserProfile> getUserProfile(
      @Header("Authorization") String authorization,
      {@Header("Access-Key") required String accessKey,
      @Header("Secret-Key") required String secretKey});
}
