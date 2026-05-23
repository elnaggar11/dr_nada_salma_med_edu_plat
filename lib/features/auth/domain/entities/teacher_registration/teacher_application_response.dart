class TeacherApplicationResponse {
  final bool? status;
  final String? message;
  final List<dynamic>? data;

  TeacherApplicationResponse({this.status, this.message, this.data});

  factory TeacherApplicationResponse.fromJson(Map<String, dynamic> json) {
    return TeacherApplicationResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? List<dynamic>.from(json['data']) : [],
    );
  }
}
