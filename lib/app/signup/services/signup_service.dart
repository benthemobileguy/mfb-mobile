import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/login/domain/model/response/login_response.dart';
import 'package:tampay_mobile/app/signup/data/remote/signup_repository_impl.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_wallet_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_bvn_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/tier2_upgrade_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify-bvn-otp-request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_email_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_phone_number.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_pin_request.dart';
import 'package:tampay_mobile/base/failure.dart';
import 'package:tampay_mobile/base/resizer/error_handler.dart';
import '../../../base/app_strings.dart';
import '../../../base/pref_data.dart';
import '../../../main.dart';
import '../../../manager/auth_manager.dart';

final signUpServiceProvider = Provider<SignUpService>((ref) {
  return SignUpService(ref);
});

class SignUpService {
  final Ref ref;

  SignUpService(this.ref);

  Future<Result<LoginResponse, Failure>> signUp({
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
        return Success(LoginResponse.fromJson(response ?? {}));
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
    required String otp,
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).createPassword(
            CreatePasswordRequest(
              otp: otp,
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

  Future<Result<Map<String, dynamic>, Failure>> verifyEmailOtp({
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

  Future<Result<Map<String, dynamic>, Failure>> verifyPhoneOtp({
    required String phone,
    required String otp,
  }) async {
    try {
      final response =
          await ref.read(signUpRepositoryProvider).verifyPhoneNumber(
              VerifyPhoneNumberRequest(
                phone: phone,
                otp: otp,
              ),
              "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> sendBvnOTP(
      {required String firstName,
      required String lastName,
      required String bvn}) async {
    try {
      final response =
          await ref.read(signUpRepositoryProvider).sendBvnOTPRequest(
              SendBvnOtpRequest(
                firstName: firstName,
                lastName: lastName,
                bvn: bvn,
              ),
              "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> createPasscode({
    required String confirmPasscode,
    required String newPasscode,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).setPasscode(
          CreatePasscodeRequest(
              newPasscode: newPasscode, confirmPasscode: confirmPasscode),
          "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> sendPhoneOtp({
    required String phoneNumber,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).sendOTP(
          SendOtpRequest(
            phone: phoneNumber,
          ),
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey);

      // Check if the response is null
      if (response == null) {
        return Error(Failure(message: "No response from server"));
      }

      // Safely check the status code or status message
      final statusCode = response['statusCode'] as int?;
      final status = response['status'] as String?;
      final message = response['message'] as String?;

      if (statusCode == 200 || status?.toLowerCase() == "success") {
        return Success(response);
      } else {
        // Handle the error case
        final errorMessage = message ?? "An unknown error occurred.";
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      debugPrint("Error occurred: $error");
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  Future<Result<Map<String, dynamic>, Failure>> createPin({
    required String confirmPin,
    required String pin,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).setPin(
          CreatePinRequest(newPin: pin, confirmPin: confirmPin),
          "Bearer ${getIt<AuthManager>().token!}",
          Env.accessKey,
          Env.secretKey);

      // Check if the response is null
      if (response == null) {
        return Error(Failure(message: "No response from server"));
      }

      // Safely check the status code or status message
      final statusCode = response['statusCode'] as int?;
      final status = response['status'] as String?;
      final message = response['message'] as String?;

      if (statusCode == 200 || status?.toLowerCase() == "success") {
        return Success(response);
      } else {
        // Handle the error case
        final errorMessage = message ?? "An unknown error occurred.";
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      debugPrint("Error occurred: $error");
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }

  Future<Result<Map<String, dynamic>, Failure>> saveBVNOtp({
    required String otp,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).saveBvnOTP(
          SaveBvnOtpRequest(
            otp: otp,
          ),
          "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> createWallet(
      {required String currency}) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).createWallet(
          CreateWalletRequest(accountCurrency: currency),
          "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> verifyPIN(
      {required String pin}) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).verifyPIN(
          VerifyPinRequest(pin: pin),
          "Bearer ${getIt<AuthManager>().token!}",
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

  Future<Result<Map<String, dynamic>, Failure>> tier2Upgrade({
    required String utilityBillUrl,
    required String bankStatementUrl,
    required String street,
    required String city,
    required String country,
    required String postalCode,
    required String houseNo,
    required String lga,
    required String state,
    required String occupation,
    required String employmentStatus,
    required String incomeSource,
    required String incomeRange,
    required String accountDesignation,
  }) async {
    try {
      final response = await ref.read(signUpRepositoryProvider).tier2Upgrade(
            Tier2UpgradeRequest(
              financialStatements: FinancialStatements(
                utilityBillUrl: utilityBillUrl,
                bankStatementUrl: bankStatementUrl,
              ),
              address: Address(
                street: street,
                city: city,
                country: country,
                postalCode: postalCode,
                houseNo: houseNo,
                lga: lga,
                state: state,
              ),
              employment: Employment(
                occupation: occupation,
                employmentStatus: employmentStatus.toLowerCase(),
                incomeSource: incomeSource,
                incomeRange: incomeRange,
                accountDesignation: accountDesignation,
              ),
            ),
            "Bearer ${getIt<AuthManager>().token!}",
            Env.accessKey,
            Env.secretKey,
          );

      if (response['statusCode'] == 200 || response['status'] == "Success") {
        return Success(response);
      } else {
        final errorMessage = response['message'];
        return Error(Failure(message: errorMessage));
      }
    } catch (error) {
      final errorMessage = ErrorHandler.getErrorMessage(error);
      return Error(Failure(message: errorMessage));
    }
  }
}
