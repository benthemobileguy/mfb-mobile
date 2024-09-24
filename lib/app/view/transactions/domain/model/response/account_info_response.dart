class AccountInfoResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  Data? data;
  Request? request;

  AccountInfoResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.request});

  AccountInfoResponse.fromJson(Map<String, dynamic> json) {
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
  String? accountName;
  String? accountNumber;
  String? bankCode;
  String? enquiryId;
  String? bankName;

  Data({this.accountName, this.accountNumber, this.bankCode, this.bankName});

  Data.fromJson(Map<String, dynamic> json) {
    accountName = json['accountName'];
    accountNumber = json['accountNumber'];
    bankCode = json['bankCode'];
    enquiryId = json['enquiryId'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accountName'] = accountName;
    data['accountNumber'] = accountNumber;
    data['enquiryId'] = enquiryId;
    data['bankCode'] = bankCode;
    data['bankName'] = bankName;
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
