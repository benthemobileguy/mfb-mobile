class BanksResponse {
  int? statusCode;
  String? status;
  String? time;
  String? message;
  List<Banks>? data;
  Request? request;

  BanksResponse(
      {this.statusCode,
      this.status,
      this.time,
      this.message,
      this.data,
      this.request});

  BanksResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    status = json['status'];
    time = json['time'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Banks>[];
      json['data'].forEach((v) {
        data!.add(Banks.fromJson(v));
      });
    }
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
    if (request != null) {
      data['request'] = request!.toJson();
    }
    return data;
  }
}

class Banks {
  int? sn;
  String? bank;
  String? code;

  Banks({this.sn, this.bank, this.code});

  Banks.fromJson(Map<String, dynamic> json) {
    sn = json['sn'];
    bank = json['bank'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sn'] = sn;
    data['bank'] = bank;
    data['code'] = code;
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
