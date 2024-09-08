class LoginRequest {
  String? email;
  String? password;
  DeviceInfo? deviceInfo;

  LoginRequest({this.email, this.password, this.deviceInfo});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    return data;
  }
}

class DeviceInfo {
  String? deviceOS;
  String? deviceId;
  String? type;

  DeviceInfo({this.deviceOS, this.deviceId, this.type});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceOS = json['deviceOS'];
    deviceId = json['deviceId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceOS'] = deviceOS;
    data['deviceId'] = deviceId;
    data['type'] = type;
    return data;
  }
}
