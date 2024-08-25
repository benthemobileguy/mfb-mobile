class LoginResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;

  LoginResponse(
      {this.statusCode, this.status, this.time, this.message, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['status'] = status;
    data['time'] = time;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? otp;
  String? verificationExpiresAt;
  bool? emailVerified;
  String? pin;
  String? tag;
  String? bvn;
  String? bvnPhoto;
  bool? bvnVerified;
  String? refCode;
  String? referrerId;
  int? accountCompletionStatus;
  bool? phoneNumberVerified;
  String? passCode;
  String? biometric;
  bool? enabledBiometric;
  String? dob;
  String? cardHolderId;
  Region? region;
  List<Tokens>? tokens;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.otp,
      this.verificationExpiresAt,
      this.emailVerified,
      this.pin,
      this.tag,
      this.bvn,
      this.bvnPhoto,
      this.bvnVerified,
      this.refCode,
      this.referrerId,
      this.accountCompletionStatus,
      this.phoneNumberVerified,
      this.passCode,
      this.biometric,
      this.enabledBiometric,
      this.dob,
      this.cardHolderId,
      this.region,
      this.tokens});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    otp = json['otp'];
    verificationExpiresAt = json['verificationExpiresAt'];
    emailVerified = json['emailVerified'];
    pin = json['pin'];
    tag = json['tag'];
    bvn = json['bvn'];
    bvnPhoto = json['bvnPhoto'];
    bvnVerified = json['bvnVerified'];
    refCode = json['refCode'];
    referrerId = json['referrerId'];
    accountCompletionStatus = json['accountCompletionStatus'];
    phoneNumberVerified = json['phoneNumberVerified'];
    passCode = json['passCode'];
    biometric = json['biometric'];
    enabledBiometric = json['enabledBiometric'];
    dob = json['dob'];
    cardHolderId = json['cardHolderId'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    if (json['tokens'] != null) {
      tokens = <Tokens>[];
      json['tokens'].forEach((v) {
        tokens!.add(Tokens.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['otp'] = otp;
    data['verificationExpiresAt'] = verificationExpiresAt;
    data['emailVerified'] = emailVerified;
    data['pin'] = pin;
    data['tag'] = tag;
    data['bvn'] = bvn;
    data['bvnPhoto'] = bvnPhoto;
    data['bvnVerified'] = bvnVerified;
    data['refCode'] = refCode;
    data['referrerId'] = referrerId;
    data['accountCompletionStatus'] = accountCompletionStatus;
    data['phoneNumberVerified'] = phoneNumberVerified;
    data['passCode'] = passCode;
    data['biometric'] = biometric;
    data['enabledBiometric'] = enabledBiometric;
    data['dob'] = dob;
    data['cardHolderId'] = cardHolderId;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    if (tokens != null) {
      data['tokens'] = tokens!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Region {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  String? name;
  String? flagSvg;
  String? flagPng;
  bool? active;
  bool? defaultCurrency;
  String? code;
  String? denomination;
  Currency? currency;

  Region(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.name,
      this.flagSvg,
      this.flagPng,
      this.active,
      this.defaultCurrency,
      this.code,
      this.denomination,
      this.currency});

  Region.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    name = json['name'];
    flagSvg = json['flagSvg'];
    flagPng = json['flagPng'];
    active = json['active'];
    defaultCurrency = json['default'];
    code = json['code'];
    denomination = json['demonym'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['name'] = name;
    data['flagSvg'] = flagSvg;
    data['flagPng'] = flagPng;
    data['active'] = active;
    data['default'] = defaultCurrency;
    data['code'] = code;
    data['demonym'] = denomination;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class Currency {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  String? name;
  String? code;
  String? symbol;
  bool? defaultCurrency;
  bool? active;

  Currency(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.name,
      this.code,
      this.symbol,
      this.defaultCurrency,
      this.active});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    defaultCurrency = json['default'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    data['default'] = defaultCurrency;
    data['active'] = active;
    return data;
  }
}

class Tokens {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiresIn;

  Tokens({this.accessToken, this.refreshToken, this.tokenType, this.expiresIn});

  Tokens.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    return data;
  }
}
