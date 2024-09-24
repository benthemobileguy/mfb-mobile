class InitiateTransferResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;
  Request? request;

  InitiateTransferResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.request});

  InitiateTransferResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    request =
        json['request'] != null ? Request.fromJson(json['request']) : null;
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
    if (request != null) {
      data['request'] = request!.toJson();
    }
    return data;
  }
}

class Data {
  String? wallet;
  String? paymentMethod;
  dynamic transactionFees;
  dynamic transactionAmount;
  String? idempotentKey;
  String? beneficiaryAccountName;
  String? beneficiaryAccountNumber;
  String? beneficiaryBankCode;
  bool? saveBeneficiary;
  String? payload;
  String? narration;
  String? beneficiaryId;
  String? beneficiaryBankName;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  String? transactionStatus;

  Data(
      {this.wallet,
      this.paymentMethod,
      this.transactionFees,
      this.transactionAmount,
      this.idempotentKey,
      this.beneficiaryAccountName,
      this.beneficiaryAccountNumber,
      this.beneficiaryBankCode,
      this.saveBeneficiary,
      this.payload,
      this.narration,
      this.beneficiaryId,
      this.beneficiaryBankName,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.transactionStatus});

  Data.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    paymentMethod = json['paymentMethod'];
    transactionFees = json['transactionFees'];
    transactionAmount = json['transactionAmount'];
    idempotentKey = json['idempotentKey'];
    beneficiaryAccountName = json['beneficiaryAccountName'];
    beneficiaryAccountNumber = json['beneficiaryAccountNumber'];
    beneficiaryBankCode = json['beneficiaryBankCode'];
    saveBeneficiary = json['saveBeneficiary'];
    payload = json['payload'];
    narration = json['narration'];
    beneficiaryId = json['beneficiaryId'];
    beneficiaryBankName = json['beneficiaryBankName'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    transactionStatus = json['transactionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet'] = wallet;
    data['paymentMethod'] = paymentMethod;
    data['transactionFees'] = transactionFees;
    data['transactionAmount'] = transactionAmount;
    data['idempotentKey'] = idempotentKey;
    data['beneficiaryAccountName'] = beneficiaryAccountName;
    data['beneficiaryAccountNumber'] = beneficiaryAccountNumber;
    data['beneficiaryBankCode'] = beneficiaryBankCode;
    data['saveBeneficiary'] = saveBeneficiary;
    data['payload'] = payload;
    data['narration'] = narration;
    data['beneficiaryId'] = beneficiaryId;
    data['beneficiaryBankName'] = beneficiaryBankName;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['transactionStatus'] = transactionStatus;
    return data;
  }
}

class Request {
  String? method;
  String? path;

  Request({this.method, this.path});

  Request.fromJson(Map<String, dynamic> json) {
    method = json['method'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['path'] = path;
    return data;
  }
}
