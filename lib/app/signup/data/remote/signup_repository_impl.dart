import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/env/env.dart';
import 'package:tampay_mobile/app/signup/data/client/sign_up_api_client.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/change_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/change_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset-passcode-request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_bvn_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify-bvn-otp-request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_bvn_request.dart.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_email_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_phone_number.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_pin_request.dart';

import '../../../../base/dio_provider.dart';
import '../../domain/repository/signup_repository.dart';

final signUpRepositoryProvider = Provider<SignupRepository>((ref) {
  return SignUpRepositoryImpl(SignUpApiClient(
      baseUrl: ref.read(dioProvider).options.baseUrl, ref.read(dioProvider)));
});

class SignUpRepositoryImpl implements SignupRepository {
  final SignUpApiClient _signupClient;

  SignUpRepositoryImpl(this._signupClient);

  @override
  Future changePasscode(
      ChangePasscodeRequest createAccountRequest, String authorization) async {
    try {
      final changePasscodeResponse = await _signupClient.changePasscode(
          createAccountRequest, authorization);
      return changePasscodeResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('changePasscode: $e');
    }
  }

  @override
  Future changePin(
      ChangePinRequest changePinRequest, String authorization) async {
    try {
      final changePinResponse =
          await _signupClient.changePin(changePinRequest, authorization);
      return changePinResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('changePin: $e');
    }
  }

  @override
  Future createPassword(CreatePasswordRequest createAccountRequest,
      String accessKey, String secretKey) async {
    try {
      final createPasswordResponse = await _signupClient.createPassword(
          createAccountRequest, accessKey, secretKey);
      return createPasswordResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('createPassword: $e');
    }
  }

  @override
  Future resetPasscode(
      ResetPasscodeRequest resetPasscodeRequest, String authorization) async {
    try {
      final resetPasscodeResponse = await _signupClient.resetPasscode(
          resetPasscodeRequest, authorization);
      return resetPasscodeResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('resetPasscode: $e');
    }
  }

  @override
  Future resetPassword(ResetPasswordRequest resetPassRequest, String accessKey,
      String secretKey) async {
    try {
      final resetPasswordResponse = await _signupClient.resetPassword(
          resetPassRequest, accessKey, secretKey);
      return resetPasswordResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('failed: $e');
    }
  }

  @override
  Future sendOTP(SendOtpRequest createAccountRequest, String authorization,
      String accessKey, String secretKey) async {
    try {
      final sendOtpResponse = await _signupClient.sendOtp(
          createAccountRequest, authorization, accessKey, secretKey);
      return sendOtpResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('sendOTP: $e');
    }
  }

  @override
  Future sendBvnOTPRequest(SendBvnOtpRequest sendBvnOtpRequest,
      String authorization, String accessKey, String secretKey) async {
    try {
      final sendBvnOtpResponse = await _signupClient.sendBvnOtp(
          sendBvnOtpRequest, authorization, accessKey, secretKey);
      return sendBvnOtpResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyBvnOTPRequest: $e');
    }
  }

  @override
  Future setPasscode(CreatePasscodeRequest createAccountRequest,
      String authorization, String accessKey, String secretKey) async {
    try {
      final setPasscodeResponse = await _signupClient.setPasscode(
          createAccountRequest, authorization, accessKey, secretKey);
      return setPasscodeResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyPasscode: $e');
    }
  }

  @override
  Future verifyBVN(
      VerifyBvnRequest createAccountRequest, String authorization) async {
    try {
      final verifyBvnResponse =
          await _signupClient.verifyBvn(createAccountRequest, authorization);
      return verifyBvnResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyBvn: $e');
    }
  }

  @override
  Future verifyEmail(VerifyEmailRequest verifyEmailRequest, String accessKey,
      String secretKey) async {
    try {
      final verifyEmailResponse = await _signupClient.verifyEmail(
          verifyEmailRequest, accessKey, secretKey);
      return verifyEmailResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyEmail: $e');
    }
  }

  @override
  Future verifyOTP(VerifyOtpRequest verifyOtpRequest, String accessKey,
      String secretKey) async {
    try {
      final verifyOtpResponse =
          await _signupClient.verifyOtp(verifyOtpRequest, accessKey, secretKey);
      return verifyOtpResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyOTP: $e');
    }
  }

  @override
  Future verifyPIN(
      VerifyPinRequest createAccountRequest, String authorization) async {
    try {
      final verifyPinResponse =
          await _signupClient.verifyPin(createAccountRequest, authorization);
      return verifyPinResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyPin: $e');
    }
  }

  @override
  Future verifyPasscode(
      VerifyPasscodeRequest verifyPasscodeRequest, String authorization) async {
    try {
      final verifyPasscodeResponse = await _signupClient.verifyPasscode(
          verifyPasscodeRequest, authorization);
      return verifyPasscodeResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyPasscode: $e');
    }
  }

  @override
  Future<Map<String, dynamic>?> createAccount(
      SignUpRequest createAccountRequest,
      String accessKey,
      String secretKey) async {
    try {
      final signupResponse = await _signupClient.createAccount(
          createAccountRequest, Env.accessKey, Env.secretKey);
      return signupResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future setPin(CreatePinRequest setPinRequest, String authorization,
      String accessKey, String secretKey) async {
    try {
      final setPinResponse = await _signupClient.setPin(
          setPinRequest, authorization, accessKey, secretKey);
      return setPinResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
    }
    return null;
  }

  @override
  Future verifyPhoneNumber(VerifyPhoneNumberRequest createAccountRequest,
      String authorization, String accessKey, String secretKey) async {
    try {
      final verifyPhoneNumberResponse = await _signupClient.verifyPhoneNumber(
          createAccountRequest, authorization, accessKey, secretKey);
      return verifyPhoneNumberResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyPhoneNumber: $e');
    }
  }

  @override
  Future verifyBvnOTP(VerifyBvnOtpRequest verifyBvnOtpRequest,
      String authorization, String accessKey, String secretKey) async {
    try {
      final verifyBvnOTPResponse = await _signupClient.verifyBvnOtp(
          verifyBvnOtpRequest, authorization, accessKey, secretKey);
      return verifyBvnOTPResponse;
    } on DioException catch (e) {
      debugPrint(e.message);
      rethrow;
    } catch (e) {
      // Handle any other exceptions
      throw Exception('verifyBvnOTP: $e');
    }
  }
}
