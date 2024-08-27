import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    // Show the progress dialog before making the request
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    try {
      final result = await ref.read(signUpServiceProvider).signUp(
            email: email!,
            password: password!,
            confirmPassword: confirmPassword!,
            firstName: firstName!,
            lastName: lastName!,
            phone: phone!,
            referralCode: referralCode,
          );

      result.when(
        (success) {
          PrefData.setLogIn(true).then((value) {
            Constant.sendToNext(context, Routes.homeScreenRoute);
          });
        },
        (error) {
          // Show error as a toast notification
          showErrorToast(context, error.message);
        },
      );
    } finally {
      // Ensure the progress dialog is dismissed
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
