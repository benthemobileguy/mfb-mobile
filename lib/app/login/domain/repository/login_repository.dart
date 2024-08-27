import '../model/request/login_request.dart';

abstract class LoginRepository {
  Future<Map<String, dynamic>?> login(LoginRequest? loginRequest);
}
