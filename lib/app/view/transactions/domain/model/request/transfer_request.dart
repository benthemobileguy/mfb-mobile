class TransferRequest {
  String? wallet;
  String? beneficiaryAccountNumber;
  String? amount;
  String? narration;
  String? transferId;
  String? beneficiaryBankCode;
  String? transactionPin;

  TransferRequest(
      {this.wallet,
      this.beneficiaryAccountNumber,
      this.amount,
      this.narration,
      this.transferId,
      this.beneficiaryBankCode,
      this.transactionPin});

  TransferRequest.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    beneficiaryAccountNumber = json['beneficiaryAccountNumber'];
    amount = json['amount'];
    narration = json['narration'];
    transferId = json['transferId'];
    beneficiaryBankCode = json['beneficiaryBankCode'];
    transactionPin = json['transactionPin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet'] = wallet;
    data['beneficiaryAccountNumber'] = beneficiaryAccountNumber;
    data['amount'] = amount;
    data['narration'] = narration;
    data['transferId'] = transferId;
    data['beneficiaryBankCode'] = beneficiaryBankCode;
    data['transactionPin'] = transactionPin;
    return data;
  }
}
