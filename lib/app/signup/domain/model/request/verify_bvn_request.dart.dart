class VerifyBvnRequest {
  String? firstName;
  String? lastName;
  String? bvn;

  VerifyBvnRequest({this.firstName, this.lastName, this.bvn});

  VerifyBvnRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    bvn = json['bvn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['bvn'] = bvn;
    return data;
  }
}
