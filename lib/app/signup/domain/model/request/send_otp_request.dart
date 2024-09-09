class SendOtpRequest {
  String? phone;

  SendOtpRequest({this.phone});

  SendOtpRequest.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    return data;
  }
}
