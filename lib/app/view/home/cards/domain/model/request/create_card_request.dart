class CreateCardRequest {
  String? cardScheme;
  String? cardType;
  String? cardCurrency;
  String? openingDepositAmt;

  CreateCardRequest(
      {this.cardScheme,
      this.cardType,
      this.cardCurrency,
      this.openingDepositAmt});

  CreateCardRequest.fromJson(Map<String, dynamic> json) {
    cardScheme = json['cardScheme'];
    cardType = json['cardType'];
    cardCurrency = json['cardCurrency'];
    openingDepositAmt = json['openingDepositAmt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cardScheme'] = cardScheme;
    data['cardType'] = cardType;
    data['cardCurrency'] = cardCurrency;
    data['openingDepositAmt'] = openingDepositAmt;
    return data;
  }
}
