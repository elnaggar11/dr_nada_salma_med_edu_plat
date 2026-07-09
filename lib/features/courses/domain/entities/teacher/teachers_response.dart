class TeachersResponse {
  final bool? status;
  final String? message;
  final List<TeacherItem>? data;

  TeachersResponse({this.status, this.message, this.data});

  factory TeachersResponse.fromJson(Map<String, dynamic> json) {
    bool? parsedStatus;
    if (json['status'] is bool) {
      parsedStatus = json['status'] as bool?;
    } else if (json['status'] is String) {
      final s = json['status'].toString().toLowerCase();
      parsedStatus = s == 'true' || s == 'success';
    }

    return TeachersResponse(
      status: parsedStatus,
      message: json['message'],
      data: json['data'] != null
          ? (json['data'] as List).map((i) => TeacherItem.fromJson(i)).toList()
          : null,
    );
  }
}

class TeacherItem {
  final int? id;
  final String? name;
  final String? image;
  final String? specialty;
  final double? rating;
  final int? experienceYears;
  final int? studentsCount;
  final double? hourlyPrice;
  final double? hourlyRateAfterDiscount;
  final String? slug;

  TeacherItem({
    this.id,
    this.name,
    this.image,
    this.specialty,
    this.rating,
    this.experienceYears,
    this.studentsCount,
    this.hourlyPrice,
    this.hourlyRateAfterDiscount,
    this.slug,
  });

  factory TeacherItem.fromJson(Map<String, dynamic> json) {
    return TeacherItem(
      id: json['id'],
      name: json['full_name'],
      image: json['image'],
      specialty: json['specialty'] ?? json['specialization_title'],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      experienceYears:
          json['experience_years'] ?? json['years_experience'] ?? 0,
      studentsCount: json['students_count'] ?? 0,
      hourlyPrice: _parseDouble(json['hourly_price'] ?? json['hourly_rate']),
      hourlyRateAfterDiscount: _parseDouble(json['hourly_rate_after_discount'] ?? json['hourly_price_after_discount']),
      slug: json['slug'],
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}
