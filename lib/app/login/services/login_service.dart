import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/login/domain/model/request/login_request.dart';
import 'package:tampay_mobile/app/login/domain/model/response/login_reponse.dart';
import 'package:tampay_mobile/base/failure.dart';
import 'package:tampay_mobile/base/resizer/error_handler.dart';
import '../data/remote/login_repository_impl.dart';

final loginServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

class AuthService {
  final Ref ref;
  AuthService(this.ref);

  Future<Result<LoginResponse, Failure>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await ref.read(loginRepositoryProvider).login(
          LoginRequest(
              email: email,
              password: password,
              deviceOS: Platform.isIOS ? 'ios' : 'android'));

      // Wrap the successful response in a `Success` result
      return Success(LoginResponse.fromJson(response??{}));
    } catch (error) {
      // Use the ErrorHandler to process the error
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }
}
