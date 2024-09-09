class VerifyPhoneNumberRequest {
  String? phone;
  String? otp;

  VerifyPhoneNumberRequest({this.phone, this.otp});

  VerifyPhoneNumberRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['otp'] = otp;
    return data;
  }
}
