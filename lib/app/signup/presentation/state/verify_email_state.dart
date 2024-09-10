import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifyEmailState {
  final String otp;
  final String email;

  VerifyEmailState({required this.otp, required this.email});
}

class VerifyEmailController extends StateNotifier<VerifyEmailState> {
  VerifyEmailController() : super(VerifyEmailState(otp: '', email: ''));

  void setOtpAndEmail(String otp, String email) {
    state = VerifyEmailState(otp: otp, email: email);
  }
}

final verifyEmailProvider =
    StateNotifierProvider<VerifyEmailController, VerifyEmailState>(
        (ref) => VerifyEmailController());
