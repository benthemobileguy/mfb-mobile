class BankTransferFormState {
  final String bank;
  final String accountNumber;
  final String narration;
  final double amount;
  final bool isBankValid;
  final bool isAccountNumberValid;
  final bool isAmountValid;
  final double balance;

  BankTransferFormState({
    this.bank = '',
    this.accountNumber = '',
    this.narration = '',
    this.amount = 0.0,
    this.isBankValid = false,
    this.isAccountNumberValid = false,
    this.isAmountValid = false,
    this.balance = 1000.0, // Assuming a default balance, adjust as needed
  });

  BankTransferFormState copyWith({
    String? bank,
    String? accountNumber,
    String? narration,
    double? amount,
    bool? isBankValid,
    bool? isAccountNumberValid,
    bool? isAmountValid,
    double? balance,
  }) {
    return BankTransferFormState(
      bank: bank ?? this.bank,
      accountNumber: accountNumber ?? this.accountNumber,
      narration: narration ?? this.narration,
      amount: amount ?? this.amount,
      isBankValid: isBankValid ?? this.isBankValid,
      isAccountNumberValid: isAccountNumberValid ?? this.isAccountNumberValid,
      isAmountValid: isAmountValid ?? this.isAmountValid,
      balance: balance ?? this.balance,
    );
  }
}
