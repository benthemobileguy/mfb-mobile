import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/state/verify_email_state.dart';
import 'package:tampay_mobile/app/signup/services/signup_service.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/pref_data.dart';
import 'package:tampay_mobile/base/widget_utils.dart';

final signUpControllerProvider =
    ChangeNotifierProvider<SignUpController>((ref) {
  return SignUpController(ref);
});

class SignUpController extends ChangeNotifier {
  final Ref ref;

  SignUpController(this.ref);

  Future<void> createAccount({
    required String? firstName,
    required String? lastName,
    required String? confirmPassword,
    required String? phone,
    required String? email,
    required String? password,
    String referralCode = "",
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).signUp(
          email: email!,
          password: password!,
          confirmPassword: confirmPassword!,
          firstName: firstName!,
          lastName: lastName!,
          phone: phone!,
          referralCode: referralCode,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String otp = success.data?.otp ?? "";
        String email = success.data?.email ?? "";

        // Set the OTP and email in the VerifyEmailController
        ref.read(verifyEmailProvider.notifier).setOtpAndEmail(otp, email);

        Navigator.pushNamed(context, Routes.verifyEmailRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> createNewPassword({
    required String? email,
    required String? newPassword,
    required String? confirmPassword,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).createNewPassword(
          email: email!,
          newPassword: newPassword!,
          confirmPassword: confirmPassword!,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String message = success['message'] ?? "";
        showToast(context, message);
        Constant.sendToNext(context, Routes.loginRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> forgotPassword({
    required String? email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).resetPassword(
          email: email!,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String message = success['message'] ?? "";
        showToast(context, message);
        // Set the OTP and email in the VerifyEmailController
        ref.read(verifyEmailProvider.notifier).setOtpAndEmail("", email);
        Navigator.pushNamed(context, Routes.verifyEmailRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> verifyOTP({
    required String? otp,
    required String? email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).verifyOtp(
          channel: "email",
          to: email!,
          otp: otp!,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String message = success['message'] ?? "";
        showToast(context, message);
        Navigator.pushNamed(context, Routes.createPassRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }
}
