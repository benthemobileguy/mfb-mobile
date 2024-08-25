class SignUpRequest {
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? password;
  String? confirmPassword;
  String? deviceOS;
  String? refCode;

  SignUpRequest(
      {this.firstName,
        this.lastName,
        this.email,
        this.phone,
        this.password,
        this.confirmPassword,
        this.deviceOS,
        this.refCode});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    confirmPassword = json['confirmPassword'];
    deviceOS = json['deviceOS'];
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
    data['deviceOS'] = deviceOS;
    data['refCode'] = refCode;
    return data;
  }
}
