class VerifyPasscodeRequest {
  String? passcode;

  VerifyPasscodeRequest({this.passcode});

  VerifyPasscodeRequest.fromJson(Map<String, dynamic> json) {
    passcode = json['passcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['passcode'] = passcode;
    return data;
  }
}
