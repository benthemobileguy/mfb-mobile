class FetchCardsResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  List<Data>? data;
  Pagination? pagination;
  Request? request;

  FetchCardsResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.pagination,
      this.request});

  FetchCardsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
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
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (pagination != null) {
      data['pagination'] = pagination!.toJson();
    }
    if (request != null) {
      data['request'] = request!.toJson();
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
  String? cardNumber;
  String? cardHolderName;
  String? expiryMonth;
  String? expiryYear;
  String? cvv;
  String? balance;
  String? limit;
  bool? isActive;
  bool? frozen;
  String? cardType;
  String? cardScheme;
  String? cardCurrency;
  String? customerId;
  String? cardProviderId;
  String? cardIdFromProvider;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.cardNumber,
      this.cardHolderName,
      this.expiryMonth,
      this.expiryYear,
      this.cvv,
      this.balance,
      this.limit,
      this.isActive,
      this.frozen,
      this.cardType,
      this.cardScheme,
      this.cardCurrency,
      this.customerId,
      this.cardProviderId,
      this.cardIdFromProvider});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
    cardNumber = json['cardNumber'];
    cardHolderName = json['cardHolderName'];
    expiryMonth = json['expiryMonth'];
    expiryYear = json['expiryYear'];
    cvv = json['cvv'];
    balance = json['balance'];
    limit = json['limit'];
    isActive = json['isActive'];
    frozen = json['frozen'];
    cardType = json['cardType'];
    cardScheme = json['cardScheme'];
    cardCurrency = json['cardCurrency'];
    customerId = json['customerId'];
    cardProviderId = json['cardProviderId'];
    cardIdFromProvider = json['cardIdFromProvider'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
    data['cardNumber'] = cardNumber;
    data['cardHolderName'] = cardHolderName;
    data['expiryMonth'] = expiryMonth;
    data['expiryYear'] = expiryYear;
    data['cvv'] = cvv;
    data['balance'] = balance;
    data['limit'] = limit;
    data['isActive'] = isActive;
    data['frozen'] = frozen;
    data['cardType'] = cardType;
    data['cardScheme'] = cardScheme;
    data['cardCurrency'] = cardCurrency;
    data['customerId'] = customerId;
    data['cardProviderId'] = cardProviderId;
    data['cardIdFromProvider'] = cardIdFromProvider;
    return data;
  }
}

class Pagination {
  int? totalItems;
  int? totalPages;
  int? currentPage;
  int? limit;
  int? offset;

  Pagination(
      {this.totalItems,
      this.totalPages,
      this.currentPage,
      this.limit,
      this.offset});

  Pagination.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    currentPage = json['currentPage'];
    limit = json['limit'];
    offset = json['offset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalItems'] = totalItems;
    data['totalPages'] = totalPages;
    data['currentPage'] = currentPage;
    data['limit'] = limit;
    data['offset'] = offset;
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
