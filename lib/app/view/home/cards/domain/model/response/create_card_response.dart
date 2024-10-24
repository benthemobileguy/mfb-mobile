class CreateCardResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;
  Request? request;

  CreateCardResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.request});

  CreateCardResponse.fromJson(Map<String, dynamic> json) {
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
  String? cardNumber;
  String? cardHolderName;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;
  String? balance;
  String? limit;
  bool? isActive;
  String? cardType;
  String? cardScheme;
  String? cardCurrency;
  String? customerId;
  String? cardProviderId;
  String? cardIdFromProvider;
  String? id;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  int? version;
  bool? frozen;

  Data(
      {this.cardNumber,
      this.cardHolderName,
      this.expiryMonth,
      this.expiryYear,
      this.cvv,
      this.balance,
      this.limit,
      this.isActive,
      this.cardType,
      this.cardScheme,
      this.cardCurrency,
      this.customerId,
      this.cardProviderId,
      this.cardIdFromProvider,
      this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.frozen});

  Data.fromJson(Map<String, dynamic> json) {
    cardNumber = json['cardNumber'];
    cardHolderName = json['cardHolderName'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    cvv = json['cvv'];
    balance = json['balance'];
    limit = json['limit'];
    isActive = json['isActive'];
    cardType = json['cardType'];
    cardScheme = json['cardScheme'];
    cardCurrency = json['cardCurrency'];
    customerId = json['customerId'];
    cardProviderId = json['cardProviderId'];
    cardIdFromProvider = json['cardIdFromProvider'];
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    frozen = json['frozen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardNumber'] = cardNumber;
    data['cardHolderName'] = cardHolderName;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['cvv'] = cvv;
    data['balance'] = balance;
    data['limit'] = limit;
    data['isActive'] = isActive;
    data['cardType'] = cardType;
    data['cardScheme'] = cardScheme;
    data['cardCurrency'] = cardCurrency;
    data['customerId'] = customerId;
    data['cardProviderId'] = cardProviderId;
    data['cardIdFromProvider'] = cardIdFromProvider;
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['frozen'] = frozen;
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
    data['method'] = method;
    data['path'] = path;
    return data;
  }
}
