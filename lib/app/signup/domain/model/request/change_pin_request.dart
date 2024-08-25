class ChangePinRequest {
  String? oldPin;
  String? newPin;
  String? confirmPin;

  ChangePinRequest({this.oldPin, this.newPin, this.confirmPin});

  ChangePinRequest.fromJson(Map<String, dynamic> json) {
    oldPin = json['oldPin'];
    newPin = json['newPin'];
    confirmPin = json['confirmPin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPin'] = oldPin;
    data['newPin'] = newPin;
    data['confirmPin'] = confirmPin;
    return data;
  }
}
