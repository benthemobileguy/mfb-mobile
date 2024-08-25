class VerifyEmailRequest {
  String? email;
  String? otp;

  VerifyEmailRequest({this.email, this.otp});

  VerifyEmailRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['otp'] = otp;
    return data;
  }
}
