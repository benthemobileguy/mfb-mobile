import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/bank_transfer_form_state.dart';

final bankTransferFormControllerProvider =
    StateNotifierProvider<BankTransferFormController, BankTransferFormState>(
  (ref) => BankTransferFormController(),
);

class BankTransferFormController extends StateNotifier<BankTransferFormState> {
  BankTransferFormController() : super(BankTransferFormState());

  void updateBank(String bank) {
    state = state.copyWith(
      bank: bank,
      isBankValid: bank.isNotEmpty,
    );
  }

  void updateAccountNumber(String accountNumber) {
    state = state.copyWith(
      accountNumber: accountNumber,
      isAccountNumberValid: accountNumber.length >= 10,
    );
  }

  void updateNarration(String narration) {
    state = state.copyWith(
      narration: narration,
    );
  }

  void updateAmount(double amount, double maxBalance) {
    state = state.copyWith(
      amount: amount,
      isAmountValid: amount > 0 && amount <= maxBalance,
    );
  }

  void resetForm() {
    state = BankTransferFormState();
  }
}
