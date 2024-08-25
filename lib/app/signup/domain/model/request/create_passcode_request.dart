class CreatePasscodeRequest {
  String? newPasscode;
  String? confirmPasscode;

  CreatePasscodeRequest({this.newPasscode, this.confirmPasscode});

  CreatePasscodeRequest.fromJson(Map<String, dynamic> json) {
    newPasscode = json['newPasscode'];
    confirmPasscode = json['confirmPasscode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['newPasscode'] = newPasscode;
    data['confirmPasscode'] = confirmPasscode;
    return data;
  }
}
