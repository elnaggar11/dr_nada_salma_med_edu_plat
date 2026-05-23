class VerifyOtpResponse {
  bool? status;
  String? message;
  Data? data;

  VerifyOtpResponse({this.status, this.message, this.data});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic fullName;
  dynamic phoneNumber;
  dynamic email;
  dynamic image;
  dynamic accessToken;

  Data({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.image,
    this.accessToken,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    image = json['image'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['image'] = image;
    data['access_token'] = accessToken;
    return data;
  }
}
