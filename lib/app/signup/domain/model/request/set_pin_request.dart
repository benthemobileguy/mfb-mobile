class SetPinRequest {
  String? newPin;
  String? confirmPin;

  SetPinRequest({this.newPin, this.confirmPin});

  SetPinRequest.fromJson(Map<String, dynamic> json) {
    newPin = json['newPin'];
    confirmPin = json['confirmPin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newPin'] = newPin;
    data['confirmPin'] = confirmPin;
    return data;
  }
}
