class SendOtpRequest {
  String? channel;
  String? target;

  SendOtpRequest({this.channel, this.target});

  SendOtpRequest.fromJson(Map<String, dynamic> json) {
    channel = json['channel'];
    target = json['target'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['channel'] = channel;
    data['target'] = target;
    return data;
  }
}
