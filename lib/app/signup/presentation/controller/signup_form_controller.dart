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
      isPhoneValid: phone.length >= 10, // Example validation
    );
  }

  void updateReferralCode(String referralCode) {
    state = state.copyWith(referralCode: referralCode);
  }

  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: password.length >= 8, // Example validation
    );
  }

  void updateConfirmPassword(String confirmPassword) {
    state = state.copyWith(
      confirmPassword: confirmPassword,
      isConfirmPasswordValid:
      confirmPassword == state.password && confirmPassword.length >= 8,
    );
  }
}
