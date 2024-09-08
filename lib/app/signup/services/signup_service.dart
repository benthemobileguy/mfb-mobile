import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/signup/data/remote/signup_repository_impl.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_email_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/response/signup_response.dart';
import 'package:tampay_mobile/base/failure.dart';
import 'package:tampay_mobile/base/resizer/error_handler.dart';

import '../../../base/app_strings.dart';
import '../../../base/pref_data.dart';

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
      final deviceId = await ref
          .read(localStorageProvider)
          .getStringValue(AppStrings.deviceIdString);
      final response = await ref.read(signUpRepositoryProvider).createAccount(
            SignUpRequest(
              firstName: firstName,
              lastName: lastName,
              email: email,
              phone: phone,
              confirmPassword: confirmPassword,
              deviceInfo: DeviceInfo(
                deviceOS: Platform.isIOS ? "ios" : "android",
                deviceId: deviceId,
              ),
              password: password,
              refCode: referralCode,
            ),
            Env.accessKey,
            Env.secretKey,
          );
      // Check the status code before parsing the response
      if (response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          response['status'] == "Success") {
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

  Future<Result<Map<String, dynamic>, Failure>> resetPassword({
    required String email,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).resetPassword(
            ResetPasswordRequest(
              email: email,
            ),
            Env.accessKey,
            Env.secretKey,
          );
      // Check the status code before parsing the response
      if (response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          response['status'] == "Success") {
        return Success(response);
      } else {
        // Handle the error case
        final errorMessage = response['message'];
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  Future<Result<Map<String, dynamic>, Failure>> createNewPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).createPassword(
            CreatePasswordRequest(
              email: email,
              newPassword: newPassword,
              confirmPassword: confirmPassword,
            ),
            Env.accessKey,
            Env.secretKey,
          );
      // Check the status code before parsing the response
      if (response['statusCode'] == 200 ||
          response['statusCode'] == 201 ||
          response['status'] == "Success") {
        return Success(response);
      } else {
        // Handle the error case
        final errorMessage = response['message'];
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  Future<Result<Map<String, dynamic>, Failure>> verifyOtp({
    required String channel,
    required String to,
    required String otp,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).verifyEmail(
          VerifyEmailRequest(
            email: to,
            otp: otp,
          ),
          Env.accessKey,
          Env.secretKey);
      // Check the status code before parsing the response
      if (response['statusCode'] == 200 || response['status'] == "Success") {
        return Success(response);
      } else {
        // Handle the error case
        final errorMessage = response['message'];
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }
}
