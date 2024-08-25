class VerifyPinRequest {
  String? pin;

  VerifyPinRequest({this.pin});

  VerifyPinRequest.fromJson(Map<String, dynamic> json) {
    pin = json['pin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pin'] = pin;
    return data;
  }
}

