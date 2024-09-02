class ForgotPasswordFormState {
  final String email;
  final bool isEmailValid;

  ForgotPasswordFormState({
    this.email = '',
    this.isEmailValid = false,
  });

  ForgotPasswordFormState copyWith({
    String? email,
    bool? isEmailValid,
  }) {
    return ForgotPasswordFormState(
      email: email ?? this.email,
      isEmailValid: isEmailValid ?? this.isEmailValid,
    );
  }
}
