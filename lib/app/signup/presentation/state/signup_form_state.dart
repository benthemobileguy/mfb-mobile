class SignUpFormState {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String referralCode;
  final String password;
  final String confirmPassword;
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool isConfirmPasswordValid;

  SignUpFormState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phone = '',
    this.referralCode = '',
    this.password = '',
    this.confirmPassword = '',
    this.isFirstNameValid = false,
    this.isLastNameValid = false,
    this.isEmailValid = false,
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.isConfirmPasswordValid = false,
  });

  SignUpFormState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? referralCode,
    String? password,
    String? confirmPassword,
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
  }) {
    return SignUpFormState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      referralCode: referralCode ?? this.referralCode,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid:
      isConfirmPasswordValid ?? this.isConfirmPasswordValid,
    );
  }
}
