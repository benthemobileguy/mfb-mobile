import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tampay_mobile/app/login/domain/model/request/login_request.dart';
part 'login_api_client.g.dart';

@RestApi()
abstract class LoginApiClient {
  factory LoginApiClient(Dio dio, {String baseUrl}) = _LoginApiClient;

  @POST("/api/v1/auth/login")
  Future<dynamic> login(
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
    @Body() LoginRequest loginRequest,
  );
}

