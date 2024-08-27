import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/login/presentation/state/login_form_state.dart';

final loginFormControllerProvider =
StateNotifierProvider<LoginFormController, LoginFormState>(
      (ref) => LoginFormController(),
);

class LoginFormController extends StateNotifier<LoginFormState> {
  LoginFormController() : super(LoginFormState());

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      isEmailValid: _validateEmail(email),
    );
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: _validatePassword(password),
    );
  }

  void togglePasswordVisibility() {
    state = state.copyWith(
      isPasswordVisible: !state.isPasswordVisible,
    );
  }

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) {
    return password.length >= 6;
  }
}
