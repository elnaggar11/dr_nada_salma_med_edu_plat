class WatchCourseResponse {
  bool? status;
  String? message;
  List<dynamic>? data;

  WatchCourseResponse({this.status, this.message, this.data});

  WatchCourseResponse.fromJson(Map<String, dynamic> json) {
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