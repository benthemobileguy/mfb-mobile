class Tier2UpgradeRequest {
  FinancialStatements? financialStatements;
  Address? address;
  Employment? employment;

  Tier2UpgradeRequest(
      {this.financialStatements, this.address, this.employment});

  Tier2UpgradeRequest.fromJson(Map<String, dynamic> json) {
    financialStatements = json['financialStatements'] != null
        ? new FinancialStatements.fromJson(json['financialStatements'])
        : null;
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    employment = json['employment'] != null
        ? new Employment.fromJson(json['employment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.financialStatements != null) {
      data['financialStatements'] = this.financialStatements!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.employment != null) {
      data['employment'] = this.employment!.toJson();
    }
    return data;
  }
}

class FinancialStatements {
  String? utilityBillUrl;
  String? bankStatementUrl;

  FinancialStatements({this.utilityBillUrl, this.bankStatementUrl});

  FinancialStatements.fromJson(Map<String, dynamic> json) {
    utilityBillUrl = json['utilityBillUrl'];
    bankStatementUrl = json['bankStatementUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['utilityBillUrl'] = this.utilityBillUrl;
    data['bankStatementUrl'] = this.bankStatementUrl;
    return data;
  }
}

class Address {
  String? street;
  String? city;
  String? country;
  String? postalCode;
  String? houseNo;
  String? lga;
  String? state;

  Address(
      {this.street,
      this.city,
      this.country,
      this.postalCode,
      this.houseNo,
      this.lga,
      this.state});

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    country = json['country'];
    postalCode = json['postalCode'];
    houseNo = json['houseNo'];
    lga = json['lga'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['street'] = this.street;
    data['city'] = this.city;
    data['country'] = this.country;
    data['postalCode'] = this.postalCode;
    data['houseNo'] = this.houseNo;
    data['lga'] = this.lga;
    data['state'] = this.state;
    return data;
  }
}

class Employment {
  String? occupation;
  String? employmentStatus;
  String? incomeSource;
  String? incomeRange;
  String? accountDesignation;

  Employment(
      {this.occupation,
      this.employmentStatus,
      this.incomeSource,
      this.incomeRange,
      this.accountDesignation});

  Employment.fromJson(Map<String, dynamic> json) {
    occupation = json['occupation'];
    employmentStatus = json['employmentStatus'];
    incomeSource = json['incomeSource'];
    incomeRange = json['incomeRange'];
    accountDesignation = json['accountDesignation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['occupation'] = this.occupation;
    data['employmentStatus'] = this.employmentStatus;
    data['incomeSource'] = this.incomeSource;
    data['incomeRange'] = this.incomeRange;
    data['accountDesignation'] = this.accountDesignation;
    return data;
  }
}
