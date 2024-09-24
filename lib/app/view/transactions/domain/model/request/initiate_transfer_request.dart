class InitiateTransferRequest {
  String? wallet;
  String? beneficiaryAccountNumber;
  String? beneficiaryAccountName;
  String? beneficiaryBankCode;
  String? enquiryId;
  String? amount;
  String? narration;
  bool? saveBeneficiary;

  InitiateTransferRequest(
      {this.wallet,
        this.beneficiaryAccountNumber,
        this.beneficiaryAccountName,
        this.beneficiaryBankCode,
        this.enquiryId,
        this.amount,
        this.narration,
        this.saveBeneficiary});

  InitiateTransferRequest.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    beneficiaryAccountNumber = json['beneficiaryAccountNumber'];
    beneficiaryAccountName = json['beneficiaryAccountName'];
    beneficiaryBankCode = json['beneficiaryBankCode'];
    enquiryId = json['enquiryId'];
    amount = json['amount'];
    narration = json['narration'];
    saveBeneficiary = json['saveBeneficiary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['beneficiaryAccountNumber'] = this.beneficiaryAccountNumber;
    data['beneficiaryAccountName'] = this.beneficiaryAccountName;
    data['beneficiaryBankCode'] = this.beneficiaryBankCode;
    data['enquiryId'] = this.enquiryId;
    data['amount'] = this.amount;
    data['narration'] = this.narration;
    data['saveBeneficiary'] = this.saveBeneficiary;
    return data;
  }
}
