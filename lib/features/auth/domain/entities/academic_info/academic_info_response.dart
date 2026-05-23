class AcademicInfoResponse {
  bool? status;
  String? message;
  List<dynamic>? data;

  AcademicInfoResponse({this.status, this.message, this.data});

  AcademicInfoResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
