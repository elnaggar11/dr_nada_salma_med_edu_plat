import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';

class CourseReviewsResponse {
  bool? status;
  String? message;
  List<Reviews>? data;

  CourseReviewsResponse({this.status, this.message, this.data});

  CourseReviewsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    
    if (json['data'] is String) {
      message = json['data'];
    } else {
      message = json['message'] is String ? json['message'] : json['message']?.toString();
    }

    dynamic reviewsData;
    if (json['message'] is Map && json['message']['reviews'] != null) {
      reviewsData = json['message']['reviews'];
    } else {
      reviewsData = json['data'];
    }

    if (reviewsData is List) {
      data = <Reviews>[];
      for (var v in reviewsData) {
        data!.add(Reviews.fromJson(v));
      }
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
