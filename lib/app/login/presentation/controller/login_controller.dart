import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/login/services/login_service.dart';
import 'package:tampay_mobile/app/routes/app_routes.dart';
import 'package:tampay_mobile/base/constant.dart';
import 'package:tampay_mobile/base/custom_progess_dialog.dart';
import 'package:tampay_mobile/base/pref_data.dart';
import 'package:tampay_mobile/base/widget_utils.dart';

import '../../../profile/presentation/controller/profile_controller.dart';
import '../../../signup/presentation/state/verify_email_state.dart';
import '../../../view/transactions/presentation/controller/transactions_controller.dart';

final loginControllerProvider = ChangeNotifierProvider<LoginController>((ref) {
  return LoginController(ref);
});

class LoginController extends ChangeNotifier {
  final Ref ref;

  LoginController(this.ref);

  Future<void> login({
    required String? email,
    required String? password,
    required BuildContext context,
  }) async {
    // Show the progress dialog before making the request
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const CustomProgressDialog(),
    );

    try {
      final result = await ref.read(loginServiceProvider).login(
            email: email!,
            password: password!,
          );

      result.when(
        (success) async {
          await ref
              .read(localStorageProvider)
              .saveJsonData(PrefData.user, result.tryGetSuccess())
              .then((value) async {
            PrefData.setLogIn(true);
            await ref.read(profileControllerProvider).getProfile();
            await ref
                .read(transactionsControllerProvider)
                .getRecentTransactions();
            await ref.read(transactionsControllerProvider).getBanks();
            Constant.sendToNext(context, Routes.homeScreenRoute);
          });
        },
        (error) {
          // Dismiss the dialog
          Navigator.of(context, rootNavigator: true).pop();
          // Show error as a toast notification
          if (error.message.toString().contains("Email not verified")) {
            // This means the email is not verified
            ref.read(verifyEmailProvider.notifier).setOtpAndEmail("", email);
            Navigator.pushNamed(context, Routes.verifyEmailRoute);
          } else {
            showErrorToast(context, error.message);
          }
        },
      );
    } catch (e) {
      // Dismiss the dialog if an exception occurs
      Navigator.of(context, rootNavigator: true).pop();
      showErrorToast(
          context, 'An unexpected error occurred. Please try again.');
    }
  }
}
