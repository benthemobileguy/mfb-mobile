import 'package:tampay_mobile/app/signup/domain/model/request/change_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/change_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_wallet_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset-passcode-request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_bvn_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_bvn_request.dart.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_email_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_phone_number.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_pin_request.dart';

import '../model/request/verify-bvn-otp-request.dart';

abstract class SignupRepository {
  Future<dynamic> createAccount(
      SignUpRequest createAccountRequest, String accessKey, String secretKey);
  Future<dynamic> resetPassword(ResetPasswordRequest resetPassRequest,
      String accessKey, String secretKey);
  Future<dynamic> createPassword(CreatePasswordRequest createAccountRequest,
      String accessKey, String secretKey);
  Future<dynamic> setPasscode(CreatePasscodeRequest createAccountRequest,
      String authorization, String accessKey, String secretKey);
  Future<dynamic> verifyPasscode(
      VerifyPasscodeRequest createAccountRequest, String authorization);
  Future<dynamic> changePasscode(
      ChangePasscodeRequest createAccountRequest, String authorization);
  Future<dynamic> verifyEmail(VerifyEmailRequest createAccountRequest,
      String accessKey, String secretKey);
  Future<dynamic> resetPasscode(
      ResetPasscodeRequest resetPasscodeRequest, String authorization);
  Future<dynamic> verifyPhoneNumber(
      VerifyPhoneNumberRequest createAccountRequest,
      String authorization,
      String accessKey,
      String secretKey);
  Future<dynamic> verifyBVN(
      VerifyBvnRequest createAccountRequest, String authorization);
  Future<dynamic> verifyOTP(VerifyOtpRequest createAccountRequest,
      String accessKey, String secretKey);
  Future<dynamic> verifyPIN(
      VerifyPinRequest verifyPinRequest,
      String authorization,
      String accessKey,
      String secretKey);
  Future<dynamic> sendOTP(SendOtpRequest createAccountRequest,
      String authorization, String accessKey, String secretKey);
  Future<dynamic> sendBvnOTPRequest(SendBvnOtpRequest sendBvnOtpRequest,
      String authorization, String accessKey, String secretKey);
  Future<dynamic> setPin(CreatePinRequest setPinRequest, String authorization,
      String accessKey, String secretKey);
  Future<dynamic> changePin(
      ChangePinRequest changePinRequest, String authorization);
  Future<dynamic> saveBvnOTP(SaveBvnOtpRequest verifyBvnOtpRequest,
      String authorization, String accessKey, String secretKey);
  Future<dynamic> createWallet(CreateWalletRequest createWalletRequest,
      String authorization, String accessKey, String secretKey);
}
