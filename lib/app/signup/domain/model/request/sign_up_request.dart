class SignUpRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  DeviceInfo? deviceInfo;
  String? refCode;

  SignUpRequest(
      {this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.password,
      this.confirmPassword,
      this.deviceInfo,
      this.refCode});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    deviceInfo = json['deviceInfo'] != null
        ? DeviceInfo.fromJson(json['deviceInfo'])
        : null;
    refCode = json['refCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['confirmPassword'] = confirmPassword;
    if (deviceInfo != null) {
      data['deviceInfo'] = deviceInfo!.toJson();
    }
    data['refCode'] = refCode;
    return data;
  }
}

class DeviceInfo {
  String? deviceOS;
  String? deviceId;

  DeviceInfo({this.deviceOS, this.deviceId});

  DeviceInfo.fromJson(Map<String, dynamic> json) {
    deviceOS = json['deviceOS'];
    deviceId = json['deviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deviceOS'] = deviceOS;
    data['deviceId'] = deviceId;
    return data;
  }
}
