class SubjectDetailsResponse {
  final bool? status;
  final String? message;
  final SubjectDetailsData? data;

  SubjectDetailsResponse({this.status, this.message, this.data});

  factory SubjectDetailsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectDetailsResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? SubjectDetailsData.fromJson(json['data']) : null,
    );
  }
}

class SubjectDetailsData {
  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final double? discountPercentage;
  final bool? hasDiscount;
  final SubjectSpecialty? specialty;
  final List<SubjectSpecialty>? specialties;
  final int? teachersCount;
  final double? minHourlyRate;

  SubjectDetailsData({
    this.id,
    this.name,
    this.description,
    this.image,
    this.discountPercentage,
    this.hasDiscount,
    this.specialty,
    this.specialties,
    this.teachersCount,
    this.minHourlyRate,
  });

  factory SubjectDetailsData.fromJson(Map<String, dynamic> json) {
    var specList = json['specialties'] as List?;
    return SubjectDetailsData(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      discountPercentage: (json['discount_percentage'] as num?)?.toDouble(),
      hasDiscount: json['has_discount'] ?? false,
      specialty: json['specialty'] != null ? SubjectSpecialty.fromJson(json['specialty']) : null,
      specialties: specList != null ? specList.map((i) => SubjectSpecialty.fromJson(i)).toList() : null,
      teachersCount: json['teachers_count'] ?? 0,
      minHourlyRate: (json['min_hourly_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }
}

class SubjectSpecialty {
  final int? id;
  final String? name;
  final int? teachersCount; // Nullable, fallback to mock counts if needed

  SubjectSpecialty({this.id, this.name, this.teachersCount = 0});

  factory SubjectSpecialty.fromJson(Map<String, dynamic> json) {
    return SubjectSpecialty(
      id: json['id'],
      name: json['name'],
      teachersCount: json['teachers_count'] ?? 0,
    );
  }
}
