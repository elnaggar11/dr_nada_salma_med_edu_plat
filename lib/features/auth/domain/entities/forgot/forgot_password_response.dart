class ForgotPasswordResponse {
  bool? status;
  String? message;
  List<dynamic>? data;

  ForgotPasswordResponse({this.status, this.message, this.data});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;

    return data;
  }
}