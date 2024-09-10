class VerifyBvnOtpRequest {
  String? otp;

  VerifyBvnOtpRequest({this.otp});

  VerifyBvnOtpRequest.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    return data;
  }
}
