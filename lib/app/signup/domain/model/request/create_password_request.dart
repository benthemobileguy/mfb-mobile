class CreatePasswordRequest {
  String? otp;
  String? email;
  String? newPassword;
  String? confirmPassword;

  CreatePasswordRequest(
      {this.otp, this.email, this.newPassword, this.confirmPassword});

  CreatePasswordRequest.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    email = json['email'];
    newPassword = json['newPassword'];
    confirmPassword = json['confirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['otp'] = otp;
    data['email'] = email;
    data['newPassword'] = newPassword;
    data['confirmPassword'] = confirmPassword;
    return data;
  }
}
