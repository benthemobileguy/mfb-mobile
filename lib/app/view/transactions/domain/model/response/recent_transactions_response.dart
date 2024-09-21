class RecentTransactionsResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  List<Data>? data;
  Pagination? pagination;
  Request? request;

  RecentTransactionsResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.pagination,
      this.request});

  RecentTransactionsResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
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
  String? currency;
  String? transactionType;
  String? paymentMethod;
  String? amount;
  String? referenceId;
  String? providerReferenceId;
  String? narration;
  String? description;
  String? status;
  String? balanceBefore;
  String? failureReason;

  Data(
      {this.id,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.version,
      this.currency,
      this.transactionType,
      this.paymentMethod,
      this.amount,
      this.referenceId,
      this.providerReferenceId,
      this.narration,
      this.description,
      this.status,
      this.balanceBefore,
      this.failureReason});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    version = json['version'];
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
    failureReason = json['failureReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['deletedAt'] = deletedAt;
    data['version'] = version;
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
    data['failureReason'] = failureReason;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['method'] = method;
    data['path'] = path;
    return data;
  }
}
