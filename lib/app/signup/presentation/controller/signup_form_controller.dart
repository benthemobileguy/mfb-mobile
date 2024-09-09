import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tampay_mobile/app/signup/presentation/state/signup_form_state.dart';

final signUpFormControllerProvider =
    StateNotifierProvider<SignUpFormController, SignUpFormState>((ref) {
  return SignUpFormController();
});

class SignUpFormController extends StateNotifier<SignUpFormState> {
  SignUpFormController() : super(SignUpFormState());

  void updateFirstName(String firstName) {
    state = state.copyWith(
      firstName: firstName,
      isFirstNameValid: firstName.isNotEmpty,
    );
  }

  void updatePassword(String password) {
    // Regex for conditions
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$&*~^]'));
    bool hasMinLength = password.length >= 8;

    state = state.copyWith(
      password: password,
      isPasswordValid:
          hasUppercase && hasDigits && hasSpecialCharacters && hasMinLength,
      hasUppercase: hasUppercase,
      hasDigits: hasDigits,
      hasSpecialCharacters: hasSpecialCharacters,
      hasMinLength: hasMinLength,
    );
  }

  void updateLastName(String lastName) {
    state = state.copyWith(
      lastName: lastName,
      isLastNameValid: lastName.isNotEmpty,
    );
  }

  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
      isEmailValid: email.contains('@'), // Simple validation
    );
  }

  void updatePhone(String phone) {
    state = state.copyWith(
      phone: phone,
      isPhoneValid: phone.length == 11, // Example validation
    );
  }

  void updateReferralCode(String referralCode) {
    state = state.copyWith(referralCode: referralCode);
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      isConfirmPasswordValid:
          confirmPassword == state.password && confirmPassword.length >= 8,
    );
  }

  void resetForm() {
    state = SignUpFormState(
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      referralCode: '',
      password: '',
      confirmPassword: '',
      isFirstNameValid: false,
      isLastNameValid: false,
      isEmailValid: false,
      isPhoneValid: false,
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      hasUppercase: false,
      hasDigits: false,
      hasSpecialCharacters: false,
      hasMinLength: false,
    );
  }
}
