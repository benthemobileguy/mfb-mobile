import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/change_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/change_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/create_pin_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset-passcode-request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/reset_password_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/send_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/sign_up_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_bvn_request.dart.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_email_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_otp_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_passcode_request.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_phone_number.dart';
import 'package:tampay_mobile/app/signup/domain/model/request/verify_pin_request.dart';
part 'sign_up_api_client.g.dart';

@RestApi()
abstract class SignUpApiClient {
  factory SignUpApiClient(Dio dio, {String baseUrl}) = _SignUpApiClient;

  @POST("api/v1/auth/register")
  Future<dynamic> createAccount(
    @Body() SignUpRequest createAccountRequest,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @POST("api/v1/auth/forgot-password")
  Future<dynamic> resetPassword(
    @Body() ResetPasswordRequest resetPassRequest,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @POST("api/v1/auth/new-password")
  Future<dynamic> createPassword(
    @Body() CreatePasswordRequest createAccountRequest,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @PATCH("api/v1/profiles/me/passcode/create")
  Future<dynamic> setPasscode(
    @Body() CreatePasscodeRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @PATCH("api/v1/profiles/me/passcode/verification")
  Future<dynamic> verifyPasscode(
    @Body() VerifyPasscodeRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @PATCH("api/v1/profiles/me/passcode/update")
  Future<dynamic> changePasscode(
    @Body() ChangePasscodeRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/profiles/me/passcode/reset")
  Future<dynamic> resetPasscode(
    @Body() ResetPasscodeRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/profiles/me/pin/create")
  Future<dynamic> setPin(
    @Body() CreatePinRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/profiles/me/pin/verification")
  Future<dynamic> verifyPin(
    @Body() VerifyPinRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/profiles/me/pin/update")
  Future<dynamic> changePin(
    @Body() ChangePinRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/verification/bvn")
  Future<dynamic> verifyBvn(
    @Body() VerifyBvnRequest createAccountRequest,
    @Header("Authorization") String authorization,
  );
  @POST("api/v1/verification/otp/validation")
  Future<dynamic> verifyOtp(
    @Body() VerifyOtpRequest createAccountRequest,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @POST("api/v1/verification/email")
  Future<dynamic> verifyEmail(
    @Body() VerifyEmailRequest createAccountRequest,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @POST("api/v1/verification/phone-number/send-otp")
  Future<dynamic> sendOtp(
    @Body() SendOtpRequest createAccountRequest,
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
  @POST("api/v1/verification/phone-number/verify-otp")
  Future<dynamic> verifyPhoneNumber(
    @Body() VerifyPhoneNumberRequest createAccountRequest,
    @Header("Authorization") String authorization,
    @Header("Access-Key") String accessKey,
    @Header("Secret-Key") String secretKey,
  );
}
