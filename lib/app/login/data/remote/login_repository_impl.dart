import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/login/data/client/login_api_client.dart';
import 'package:tampay_mobile/app/login/domain/model/request/login_request.dart';
import 'package:tampay_mobile/app/login/domain/model/response/login_reponse.dart';
import 'package:tampay_mobile/app/login/domain/repository/login_repository.dart';
import 'package:tampay_mobile/base/dio_provider.dart';

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepositoryImpl(LoginApiClient(
      baseUrl: ref.read(dioProvider).options.baseUrl, ref.read(dioProvider)));
});

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiClient _loginClient;

  LoginRepositoryImpl(this._loginClient);

  @override
  Future<Map<String, dynamic>?> login(LoginRequest? loginRequest) async {
    try {
      final loginResponse =
          await _loginClient.login(Env.accessKey, Env.secretKey, loginRequest!);
      return loginResponse;
    } on DioException catch (e) {
      debugPrint('DioException caught: $e');
      // Rethrow the exception so it can be caught by the AuthService
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Login failed: $e');
    }
  }
}
