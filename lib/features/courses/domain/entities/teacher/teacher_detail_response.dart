class TeacherDetailResponse {
  final bool? status;
  final String? message;
  final TeacherDetail? data;

  TeacherDetailResponse({this.status, this.message, this.data});

  factory TeacherDetailResponse.fromJson(Map<String, dynamic> json) {
    return TeacherDetailResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? TeacherDetail.fromJson(json['data']) : null,
    );
  }
}

class TeacherDetail {
  final int? id;
  final String? name;
  final String? image;
  final bool? isVerified;
  final double? rating;
  final int? reviewsCount;
  final String? city;
  final String? country;
  final String? countryFlag;
  final double? hourlyPrice;
  final List<String>? languages;
  final int? studentsCount;
  final int? experienceYears;
  final String? bio;
  final String? videoUrl;
  final TargetAudience? targetAudience;
  final List<TeachingExperience>? teachingExperiences;
  final Map<String, List<String>>? availability;
  final List<TeacherReview>? reviews;

  TeacherDetail({
    this.id,
    this.name,
    this.image,
    this.isVerified,
    this.rating,
    this.reviewsCount,
    this.city,
    this.country,
    this.countryFlag,
    this.hourlyPrice,
    this.languages,
    this.studentsCount,
    this.experienceYears,
    this.bio,
    this.videoUrl,
    this.targetAudience,
    this.teachingExperiences,
    this.availability,
    this.reviews,
  });

  factory TeacherDetail.fromJson(Map<String, dynamic> json) {
    return TeacherDetail(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isVerified: json['is_verified'],
      rating: (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'],
      city: json['city'],
      country: json['country'],
      countryFlag: json['country_flag'],
      hourlyPrice: (json['hourly_price'] as num?)?.toDouble(),
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
      studentsCount: json['students_count'],
      experienceYears: json['experience_years'],
      bio: json['bio'],
      videoUrl: json['video_url'],
      targetAudience: json['target_audience'] != null
          ? TargetAudience.fromJson(json['target_audience'])
          : null,
      teachingExperiences: json['teaching_experiences'] != null
          ? (json['teaching_experiences'] as List)
                .map((i) => TeachingExperience.fromJson(i))
                .toList()
          : null,
      availability: json['availability'] != null
          ? (json['availability'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(key, List<String>.from(value)),
            )
          : null,
      reviews: json['reviews'] != null
          ? (json['reviews'] as List)
                .map((i) => TeacherReview.fromJson(i))
                .toList()
          : null,
    );
  }
}

class TargetAudience {
  final String? gender;
  final List<String>? levels;

  TargetAudience({this.gender, this.levels});

  factory TargetAudience.fromJson(Map<String, dynamic> json) {
    return TargetAudience(
      gender: json['gender'],
      levels: json['levels'] != null ? List<String>.from(json['levels']) : null,
    );
  }
}

class TeachingExperience {
  final String? country;
  final String? countryFlag;
  final String? duration;
  final String? description;

  TeachingExperience({
    this.country,
    this.countryFlag,
    this.duration,
    this.description,
  });

  factory TeachingExperience.fromJson(Map<String, dynamic> json) {
    return TeachingExperience(
      country: json['country'],
      countryFlag: json['country_flag'],
      duration: json['duration'],
      description: json['description'],
    );
  }
}

class TeacherReview {
  final String? userName;
  final String? userImage;
  final double? rating;
  final String? comment;
  final String? date;

  TeacherReview({
    this.userName,
    this.userImage,
    this.rating,
    this.comment,
    this.date,
  });

  factory TeacherReview.fromJson(Map<String, dynamic> json) {
    return TeacherReview(
      userName: json['user_name'],
      userImage: json['user_image'],
      rating: (json['rating'] as num?)?.toDouble(),
      comment: json['comment'],
      date: json['date'],
    );
  }
}
