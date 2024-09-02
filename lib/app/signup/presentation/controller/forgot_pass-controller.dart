import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/state/forgot_pass_form_state.dart';

final forgotPassFormControllerProvider =
StateNotifierProvider<forgotPassFormController, ForgotPasswordFormState>((ref) {
  return forgotPassFormController();
});

class forgotPassFormController extends StateNotifier<ForgotPasswordFormState> {
  forgotPassFormController() : super(ForgotPasswordFormState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      isEmailValid: _validateEmail(email),
    );
  }

  bool _validateEmail(String email) {
    // Add more sophisticated email validation logic if needed
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
