class TransferResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;
  Request? request;

  TransferResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.request});

  TransferResponse.fromJson(Map<String, dynamic> json) {
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
  String? currency;
  String? transactionType;
  String? paymentMethod;
  int? amount;
  String? referenceId;
  String? providerReferenceId;
  String? narration;
  String? description;
  String? status;
  String? balanceBefore;
  String? beneficiaryName;
  String? beneficiaryBank;
  Wallet? wallet;
  String? failureReason;
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;

  Data(
      {this.currency,
      this.transactionType,
      this.paymentMethod,
      this.amount,
      this.referenceId,
      this.providerReferenceId,
      this.narration,
      this.description,
      this.status,
      this.balanceBefore,
      this.beneficiaryName,
      this.beneficiaryBank,
      this.wallet,
      this.failureReason,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version});

  Data.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    transactionType = json['transactionType'];
    paymentMethod = json['paymentMethod'];
    amount = json['amount'];
    referenceId = json['referenceId'];
    providerReferenceId = json['providerReferenceId'];
    narration = json['narration'];
    description = json['description'];
    status = json['status'];
    balanceBefore = json['balanceBefore'];
    beneficiaryName = json['beneficiaryName'];
    beneficiaryBank = json['beneficiaryBank'];
    wallet =
        json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    failureReason = json['failureReason'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['transactionType'] = transactionType;
    data['paymentMethod'] = paymentMethod;
    data['amount'] = amount;
    data['referenceId'] = referenceId;
    data['providerReferenceId'] = providerReferenceId;
    data['narration'] = narration;
    data['description'] = description;
    data['status'] = status;
    data['balanceBefore'] = balanceBefore;
    data['beneficiaryName'] = beneficiaryName;
    data['beneficiaryBank'] = beneficiaryBank;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    data['failureReason'] = failureReason;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    return data;
  }
}

class Wallet {
  String? id;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? version;
  int? balance;
  String? currency;
  bool? isActive;
  bool? isDefault;
  String? status;
  String? dailyDepositLimit;
  String? dailyWithdrawalLimit;
  String? totalDepositsToday;
  int? totalWithdrawalsToday;
  bool? canTransfer;
  String? accountId;

  Wallet(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.balance,
      this.currency,
      this.isActive,
      this.isDefault,
      this.status,
      this.dailyDepositLimit,
      this.dailyWithdrawalLimit,
      this.totalDepositsToday,
      this.totalWithdrawalsToday,
      this.canTransfer,
      this.accountId});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    balance = json['balance'];
    currency = json['currency'];
    isActive = json['isActive'];
    isDefault = json['isDefault'];
    status = json['status'];
    dailyDepositLimit = json['dailyDepositLimit'];
    dailyWithdrawalLimit = json['dailyWithdrawalLimit'];
    totalDepositsToday = json['totalDepositsToday'];
    totalWithdrawalsToday = json['totalWithdrawalsToday'];
    canTransfer = json['canTransfer'];
    accountId = json['accountId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['balance'] = balance;
    data['currency'] = currency;
    data['isActive'] = isActive;
    data['isDefault'] = isDefault;
    data['status'] = status;
    data['dailyDepositLimit'] = dailyDepositLimit;
    data['dailyWithdrawalLimit'] = dailyWithdrawalLimit;
    data['totalDepositsToday'] = totalDepositsToday;
    data['totalWithdrawalsToday'] = totalWithdrawalsToday;
    data['canTransfer'] = canTransfer;
    data['accountId'] = accountId;
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
