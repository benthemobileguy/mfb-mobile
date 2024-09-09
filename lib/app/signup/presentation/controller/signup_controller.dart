import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_form_controller.dart';
import 'package:tampay_mobile/app/signup/presentation/state/verify_email_state.dart';
import 'package:tampay_mobile/app/signup/services/signup_service.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import '../../../../base/pref_data.dart';
import '../../../profile/presentation/controller/profile_controller.dart';
import '../../../profile/services/profile_service.dart';

final phoneNumberProvider = StateProvider<String?>((ref) {
  return null;
});
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
      (success) async {
        String otp = success.data?.otp ?? "";
        String email = success.data?.email ?? "";

        // Set the OTP and email in the VerifyEmailController
        await ref
            .read(localStorageProvider)
            .saveJsonData(PrefData.user, result.tryGetSuccess())
            .then((value) {
          ref.read(verifyEmailProvider.notifier).setOtpAndEmail(otp, email);
        });

        Navigator.pushNamed(context, Routes.verifyEmailRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> createNewPassword({
    required String? otp,
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
          otp: otp!,
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

  Future<void> verifyEmailOTP({
    required String? otp,
    required String? email,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).verifyEmailOtp(
          to: email!,
          otp: otp!,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String message = success['message'] ?? "";
        showToast(context, message);
        ref.read(profileControllerProvider).getProfile().then((value) {
          if (ref.watch(signUpFormControllerProvider).email.isEmpty) {
            // Coming from the forgot password screen
            Navigator.pushNamed(context, Routes.createPassRoute);
          } else {
            // Coming from the sign up screen
            Navigator.pushNamed(context, Routes.homeScreenRoute);
          }
        });
      },
      (error) {
        showErrorToast(context, "Invalid OTP, please try again");
      },
    );
  }

  Future<void> sendPhoneOTP({
    required String? phoneNumber,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).sendPhoneOtp(
          phoneNumber: phoneNumber!,
        );
    Navigator.pop(context);
    result.when(
      (success) {
        String message = success['message'] ?? "";
        showToast(context, message);
        Navigator.pushNamed(context, Routes.verifyPhoneConfirmationRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> verifyPhoneOTP({
    required String? phone,
    required String? otp,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref.read(signUpServiceProvider).verifyPhoneOtp(
          phone: phone!,
          otp: otp!,
        );
    Navigator.pop(context);
    result.when(
      (success) async {
        String message = success['message'] ?? "";
        showToast(context, message);

        // Fetch the updated profile after phone verification
        await ref.read(profileControllerProvider).getProfile();

        // Navigate to home screen or any relevant screen
        Navigator.pushNamed(context, Routes.homeScreenRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }
}
