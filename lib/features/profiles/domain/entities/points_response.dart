class PointsResponse {
  bool? status;
  String? message;
  Data? data;

  PointsResponse({this.status, this.message, this.data});

  PointsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? userId;
  String? fullName;
  int? myPoints;
  List<Courses>? courses;

  Data({this.userId, this.fullName, this.myPoints, this.courses});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    myPoints = json['my_points'];
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(new Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['full_name'] = fullName;
    data['my_points'] = myPoints;
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  int? orderId;
  int? points;
  String? totalAmount;
  List<Course>? course;
  String? createdAt;

  Courses(
      {this.orderId,
        this.points,
        this.totalAmount,
        this.course,
        this.createdAt});

  Courses.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    points = json['points'];
    totalAmount = json['total_amount'];
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(new Course.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['points'] = points;
    data['total_amount'] = totalAmount;
    if (course != null) {
      data['course'] = course!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Course {
  int? id;
  dynamic title;
 dynamic slug;
  dynamic semiDescription;
  dynamic longDescription;

  Course(
      {this.id,
        this.title,
        this.slug,
        this.semiDescription,
        this.longDescription});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    semiDescription = json['semi_description'];
    longDescription = json['long_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['semi_description'] = semiDescription;
    data['long_description'] = longDescription;
    return data;
  }
}