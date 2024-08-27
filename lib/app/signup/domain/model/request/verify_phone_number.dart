class VerifyPhoneNumberRequest {
  String? phoneNumber;

  VerifyPhoneNumberRequest({this.phoneNumber});

  VerifyPhoneNumberRequest.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    return data;
  }
}
