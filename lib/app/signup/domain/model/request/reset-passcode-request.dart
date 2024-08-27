class ResetPasscodeRequest {
  String? email;

  ResetPasscodeRequest({this.email});

  ResetPasscodeRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
