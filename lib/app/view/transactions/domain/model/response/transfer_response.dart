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
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    request =
        json['request'] != null ? new Request.fromJson(json['request']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['status'] = this.status;
    data['time'] = this.time;
    data['message'] = this.message;
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
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    failureReason = json['failureReason'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['transactionType'] = this.transactionType;
    data['paymentMethod'] = this.paymentMethod;
    data['amount'] = this.amount;
    data['referenceId'] = this.referenceId;
    data['providerReferenceId'] = this.providerReferenceId;
    data['narration'] = this.narration;
    data['description'] = this.description;
    data['status'] = this.status;
    data['balanceBefore'] = this.balanceBefore;
    data['beneficiaryName'] = this.beneficiaryName;
    data['beneficiaryBank'] = this.beneficiaryBank;
    if (this.wallet != null) {
      data['wallet'] = this.wallet!.toJson();
    }
    data['failureReason'] = this.failureReason;
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['version'] = this.version;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['version'] = this.version;
    data['balance'] = this.balance;
    data['currency'] = this.currency;
    data['isActive'] = this.isActive;
    data['isDefault'] = this.isDefault;
    data['status'] = this.status;
    data['dailyDepositLimit'] = this.dailyDepositLimit;
    data['dailyWithdrawalLimit'] = this.dailyWithdrawalLimit;
    data['totalDepositsToday'] = this.totalDepositsToday;
    data['totalWithdrawalsToday'] = this.totalWithdrawalsToday;
    data['canTransfer'] = this.canTransfer;
    data['accountId'] = this.accountId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['method'] = this.method;
    data['path'] = this.path;
    return data;
  }
}
