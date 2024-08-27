import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/signup/data/remote/signup_repository_impl.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/response/signup_response.dart';
import 'package:tampay_mobile/base/failure.dart';
import 'package:tampay_mobile/base/resizer/error_handler.dart';

final signUpServiceProvider = Provider<SignUpService>((ref) {
  return SignUpService(ref);
});

class SignUpService {
  final Ref ref;
  SignUpService(this.ref);

  Future<Result<SignUpResponse, Failure>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    String? referralCode,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).createAccount(
        SignUpRequest(
          firstName: firstName,
          lastName: lastName,
          email: email,
          phone: phone,
          confirmPassword: confirmPassword,
          deviceOS: Platform.isIOS ? "ios" : "android",
          password: password,
          refCode: referralCode,
        ),
        Env.accessKey,
        Env.secretKey,
      );
      print("sdsdsd");
  print(response);
      // Check the status code before parsing the response
      if (response['statusCode'] == 200 || response['status'] == "Success") {
        return Success(SignUpResponse.fromJson(response ?? {}));
      } else {
        // Handle the error case
        final errorMessage = response['message'] is List
            ? response['message'].join(", ")
            : response['message'];
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }
}
