class RegisterResponse {
  bool? status;
  String? message;
  List<dynamic>? data;

  RegisterResponse({this.status, this.message, this.data});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <dynamic>[];
     /* json['data'].forEach((v) {
        data!.add( dynamic.fromJson(v));
      });*/
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}