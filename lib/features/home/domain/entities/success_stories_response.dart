class SuccessStoriesResponse {
  bool? status;
  String? message;
  List<Data>? data;

  SuccessStoriesResponse({this.status, this.message, this.data});

  SuccessStoriesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
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

class Data {
  int? id;
  User? user;
  dynamic courseName;
  dynamic content;
  dynamic rating;
  dynamic createdAt;

  Data({
    this.id,
    this.user,
    this.courseName,
    this.content,
    this.rating,
    this.createdAt,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    courseName = json['course_name'];
    content = json['content'];
    rating = json['rating'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['course_name'] = courseName;
    data['content'] = content;
    data['rating'] = rating;
    data['created_at'] = createdAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic fullName;
  dynamic image;

  User({this.id, this.fullName, this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['image'] = image;
    return data;
  }
}
