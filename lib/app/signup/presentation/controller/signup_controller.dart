import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/domain/model/response/signup_response.dart';
import 'package:tampay_mobile/app/signup/presentation/controller/signup_form_controller.dart';
import 'package:tampay_mobile/app/signup/presentation/state/verify_email_state.dart';
import 'package:tampay_mobile/app/signup/services/signup_service.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/widget_utils.dart';
import '../../../../base/pref_data.dart';
import '../../../../main.dart';
import '../../../../manager/auth_manager.dart';
import '../../../login/domain/model/response/login_response.dart';
import '../../../profile/presentation/controller/profile_controller.dart';

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
        // Thoroughly log the response data
        String otp = success.data?.otp ?? "";
        String email = success.data?.email ?? "";

        final loginResponse = success;

        // Save the LoginResponse object in local storage
        await ref
            .read(localStorageProvider)
            .saveJsonData(PrefData.user, loginResponse.toJson());

        // Authenticate the user using AuthManager
        getIt<AuthManager>().authenticateUser(loginResponse);

        // Set the OTP and email in the VerifyEmailController
        ref.read(verifyEmailProvider.notifier).setOtpAndEmail(otp, email);

        // Navigate to the verify email route
        Navigator.pushNamed(context, Routes.verifyEmailRoute);
      },
      (error) {
        debugPrint("Signup error: ${error.message}");
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
        ref.read(profileControllerProvider).getProfile().then((value) async {
          if (ref.watch(signUpFormControllerProvider).email.isEmpty) {
            // Coming from the forgot password screen
            Navigator.pushNamed(context, Routes.createPassRoute);
          } else {
            await ref.read(localStorageProvider).getJsonData(PrefData.user);
            // Coming from the sign up screen
            PrefData.setLogIn(true);
            await ref.read(profileControllerProvider).getProfile();
            Constant.sendToNext(context, Routes.homeScreenRoute);
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
        Navigator.pushReplacementNamed(context, Routes.verifyPhoneConfirmationRoute);
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

        Navigator.pop(context);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> sendBvnPhoneOTP({
    required String? firstName,
    required String? lastName,
    required String? bvn,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result = await ref
        .read(signUpServiceProvider)
        .sendBvnOTP(firstName: firstName!, lastName: lastName!, bvn: bvn!);
    Navigator.pop(context);
    result.when(
      (success) async {
        String message = success['message'] ?? "";
        showToast(context, message);
        Constant.sendToReplacementNext(context, Routes.verifyBvnOTPRoute);
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> verifyBvnOTP({
    required String? otp,
    required BuildContext context,
  }) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    final result =
        await ref.read(signUpServiceProvider).verifyBVNOtp(otp: otp!);
    Navigator.pop(context);
    result.when(
      (success) async {
        String message = success['message'] ?? "";
        showToast(context, message);
        // Fetch the updated profile and perform navigation if the widget is still mounted
        await ref.read(profileControllerProvider).getProfile();

        // Check if the widget is still in the tree before navigating
        if (context.mounted) {
          Navigator.pop(context); // Navigate to a different screen
        }
      },
      (error) {
        showErrorToast(context, error.message);
      },
    );
  }

  Future<void> createPasscode({
    required String? newPasscode,
    required String? confirmPasscode,
    required BuildContext context,
  }) async {
    // Show the loading dialog before the async operation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    // Perform the async operation
    final result = await ref.read(signUpServiceProvider).createPasscode(
          confirmPasscode: confirmPasscode!,
          newPasscode: newPasscode!,
        );

    // Remove the loading dialog
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Dismiss the loading dialog
    }

    // Handle the result after async operation
    result.when(
      (success) async {
        String message = success['message'] ?? "";
        showToast(context, message); // Show success message

        // Fetch the updated profile and perform navigation if the widget is still mounted
        await ref.read(profileControllerProvider).getProfile();

        // Check if the widget is still in the tree before navigating
        if (context.mounted) {
          Navigator.pop(context); // Navigate to a different screen
        }
      },
      (error) {
        if (context.mounted) {
          showErrorToast(context, error.message); // Show error message
        }
      },
    );
  }

  Future<void> createTransactionPin({
    required String? newPin,
    required String? confirmPin,
    required BuildContext context,
  }) async {
    // Show the loading dialog before the async operation
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    // Perform the async operation to create the pin
    final result = await ref
        .read(signUpServiceProvider)
        .createPin(confirmPin: confirmPin!, pin: newPin!);

    // Remove the loading dialog
    if (Navigator.canPop(context)) {
      Navigator.pop(context); // Dismiss the loading dialog
    }

    // Handle the result after async operation
    result.when(
      (success) async {
        String message = success['message'] ?? "";
        showToast(context, message); // Show success message

        // Fetch the updated profile after pin creation
        await ref.read(profileControllerProvider).getProfile();

        // Check if the widget is still in the tree before navigating
        if (context.mounted) {
          Navigator.pop(context); // Navigate to a different screen if needed
        }
      },
      (error) {
        if (context.mounted) {
          showErrorToast(context, error.message); // Show error message
        }
      },
    );
  }
}
