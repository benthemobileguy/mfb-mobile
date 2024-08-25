class ChangePasscodeRequest {
  String? oldPasscode;
  String? newPasscode;
  String? confirmPasscode;

  ChangePasscodeRequest(
      {this.oldPasscode, this.newPasscode, this.confirmPasscode});

  ChangePasscodeRequest.fromJson(Map<String, dynamic> json) {
    oldPasscode = json['oldPasscode'];
    newPasscode = json['newPasscode'];
    confirmPasscode = json['confirmPasscode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['oldPasscode'] = oldPasscode;
    data['newPasscode'] = newPasscode;
    data['confirmPasscode'] = confirmPasscode;
    return data;
  }
}
