class CreateWalletRequest {
  String? accountCurrency;

  CreateWalletRequest({this.accountCurrency});

  CreateWalletRequest.fromJson(Map<String, dynamic> json) {
    accountCurrency = json['accountCurrency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountCurrency'] = accountCurrency;
    return data;
  }
}
