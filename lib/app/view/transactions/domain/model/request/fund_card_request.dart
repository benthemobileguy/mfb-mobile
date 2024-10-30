class FundCardRequest {
  String? amount;
  String? walletId;

  FundCardRequest({this.amount, this.walletId});

  FundCardRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    walletId = json['walletId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['walletId'] = walletId;
    return data;
  }
}
