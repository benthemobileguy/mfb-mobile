class LoginState {
  final bool isButtonActive;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final bool isPasswordVisible;

  LoginState({
    required this.isLoading,
    required this.isButtonActive,
    required this.isSuccess,
    required this.isFailure,
    required this.isPasswordVisible,
  });

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isButtonActive,
    bool? isFailure,
    bool? isPasswordVisible,
  }) {
    return LoginState(
      isButtonActive: isButtonActive ?? this.isButtonActive,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}
