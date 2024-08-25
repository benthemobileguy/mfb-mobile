class LoginRequest {
  String? email;
  String? password;
  String? deviceOS;

  LoginRequest({this.email, this.password, this.deviceOS});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    deviceOS = json['deviceOS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    data['deviceOS'] = deviceOS;
    return data;
  }
}
