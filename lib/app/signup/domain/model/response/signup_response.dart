class SignUpResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;
  Request? request;

  SignUpResponse({this.statusCode, this.status, this.time, this.message, this.data, this.request});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    request = json['request'] != null ? Request.fromJson(json['request']) : null;
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
    if (this.request != null) {
      data['request'] = this.request!.toJson();
    }
    return data;
  }
}

class Data {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? otp;
  String? verificationExpiresAt;
  String? refCode;
  Region? region;
  String? pin;
  String? tag;
  String? bvn;
  String? bvnPhoto;
  String? ninPhoto;
  String? nin;
  String? referrerId;
  String? passCode;
  String? biometric;
  String? dob;
  String? cardHolderId;
  String? gender;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  bool? emailVerified;
  bool? bvnVerified;
  bool? ninVerified;
  int? accountCompletionStatus;
  bool? phoneNumberVerified;
  bool? enabledBiometric;

  Data(
      {this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.otp,
        this.verificationExpiresAt,
        this.refCode,
        this.region,
        this.pin,
        this.tag,
        this.bvn,
        this.bvnPhoto,
        this.ninPhoto,
        this.nin,
        this.referrerId,
        this.passCode,
        this.biometric,
        this.dob,
        this.cardHolderId,
        this.gender,
        this.id,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.version,
        this.emailVerified,
        this.bvnVerified,
        this.ninVerified,
        this.accountCompletionStatus,
        this.phoneNumberVerified,
        this.enabledBiometric});

  Data.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    otp = json['otp'];
    verificationExpiresAt = json['verificationExpiresAt'];
    refCode = json['refCode'];
    region = json['region'] != null ? Region.fromJson(json['region']) : null;
    pin = json['pin'];
    tag = json['tag'];
    bvn = json['bvn'];
    bvnPhoto = json['bvnPhoto'];
    ninPhoto = json['ninPhoto'];
    nin = json['nin'];
    referrerId = json['referrerId'];
    passCode = json['passCode'];
    biometric = json['biometric'];
    dob = json['dob'];
    cardHolderId = json['cardHolderId'];
    gender = json['gender'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    emailVerified = json['emailVerified'];
    bvnVerified = json['bvnVerified'];
    ninVerified = json['ninVerified'];
    accountCompletionStatus = json['accountCompletionStatus'];
    phoneNumberVerified = json['phoneNumberVerified'];
    enabledBiometric = json['enabledBiometric'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['otp'] = otp;
    data['verificationExpiresAt'] = verificationExpiresAt;
    data['refCode'] = refCode;
    if (region != null) {
      data['region'] = region!.toJson();
    }
    data['pin'] = pin;
    data['tag'] = tag;
    data['bvn'] = bvn;
    data['bvnPhoto'] = bvnPhoto;
    data['ninPhoto'] = ninPhoto;
    data['nin'] = nin;
    data['referrerId'] = referrerId;
    data['passCode'] = passCode;
    data['biometric'] = biometric;
    data['dob'] = dob;
    data['cardHolderId'] = cardHolderId;
    data['gender'] = gender;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['emailVerified'] = emailVerified;
    data['bvnVerified'] = bvnVerified;
    data['ninVerified'] = ninVerified;
    data['accountCompletionStatus'] = accountCompletionStatus;
    data['phoneNumberVerified'] = phoneNumberVerified;
    data['enabledBiometric'] = enabledBiometric;
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
  bool? defaultRegion;
  String? code;
  String? demonym;
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
        this.defaultRegion,
        this.code,
        this.demonym,
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
    defaultRegion = json['default'];
    code = json['code'];
    demonym = json['demonym'];
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
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
    data['default'] = defaultRegion;
    data['code'] = code;
    data['demonym'] = demonym;
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

class Request {
  int? requestTime;

  Request({this.requestTime});

  Request.fromJson(Map<String, dynamic> json) {
    requestTime = json['requestTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['requestTime'] = requestTime;
    return data;
  }
}
