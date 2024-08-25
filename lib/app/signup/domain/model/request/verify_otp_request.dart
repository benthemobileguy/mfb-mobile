class VerifyOtpRequest {
  String? channel;
  String? to;
  String? otp;

  VerifyOtpRequest({this.channel, this.to, this.otp});

  VerifyOtpRequest.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    to = json['to'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['to'] = to;
    data['otp'] = otp;
    return data;
  }
}
