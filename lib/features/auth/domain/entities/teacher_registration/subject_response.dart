class SubjectResponse {
  bool? status;
  String? message;
  List<SubjectData>? data;

  SubjectResponse({this.status, this.message, this.data});

  factory SubjectResponse.fromJson(Map<String, dynamic> json) {
    return SubjectResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<SubjectData>.from(json['data'].map((x) => SubjectData.fromJson(x)))
          : null,
    );
  }
}

class SubjectData {
  int? id;
  String? name;
  bool isChecked;

  SubjectData({this.id, this.name, this.isChecked = false});

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      id: json['id'],
      name: json['name'],
      isChecked: false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
