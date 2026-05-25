class TeacherDetailResponse {
  final bool? status;
  final String? message;
  final TeacherDetail? data;

  TeacherDetailResponse({this.status, this.message, this.data});

  factory TeacherDetailResponse.fromJson(Map<String, dynamic> json) {
    bool? parsedStatus;
    if (json['status'] is bool) {
      parsedStatus = json['status'] as bool?;
    } else if (json['status'] is String) {
      final s = json['status'].toString().toLowerCase();
      parsedStatus = s == 'true' || s == 'success';
    }

    return TeacherDetailResponse(
      status: parsedStatus,
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
  final List<TeacherSubject>? subjects;
  final List<TeacherTimeSlot>? availableTimeSlots;
  final Map<String, List<TeacherTimeSlot>>? availableTimeSlotsByDate;

  // New raw fields in case they are used directly
  final String? fullName;
  final String? specializationTitle;
  final String? location;
  final double? averageRating;
  final int? yearsExperience;
  final double? hourlyRate;
  final String? shortBio;
  final String? about;
  final String? targetStudents;
  final String? teachingExperienceStr;
  final String? introVideoUrl;
  final String? introVideo;
  final String? bookingPolicyHint;

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
    this.subjects,
    this.availableTimeSlots,
    this.availableTimeSlotsByDate,
    this.fullName,
    this.specializationTitle,
    this.location,
    this.averageRating,
    this.yearsExperience,
    this.hourlyRate,
    this.shortBio,
    this.about,
    this.targetStudents,
    this.teachingExperienceStr,
    this.introVideoUrl,
    this.introVideo,
    this.bookingPolicyHint,
  });

  factory TeacherDetail.fromJson(Map<String, dynamic> json) {
    // Extract country and city from "location" e.g., "Egypt, Cairo"
    final locationStr = json['location'] as String?;
    String? countryPart;
    String? cityPart;
    if (locationStr != null) {
      final parts = locationStr.split(',');
      if (parts.isNotEmpty) {
        countryPart = parts[0].trim();
      }
      if (parts.length > 1) {
        cityPart = parts[1].trim();
      }
    }

    return TeacherDetail(
      id: json['id'],
      name: json['full_name'] ?? json['name'],
      image: json['image'],
      isVerified: json['is_verified'],
      rating:
          (json['average_rating'] as num?)?.toDouble() ??
          (json['rating'] as num?)?.toDouble(),
      reviewsCount: json['reviews_count'],
      city: cityPart ?? json['city'],
      country: countryPart ?? json['country'],
      countryFlag: json['country_flag'],
      hourlyPrice:
          (json['hourly_rate'] as num?)?.toDouble() ??
          (json['hourly_price'] as num?)?.toDouble(),
      languages: json['languages'] != null
          ? List<String>.from(json['languages'])
          : null,
      studentsCount: json['students_count'],
      experienceYears: json['years_experience'] ?? json['experience_years'],
      bio: json['about'] ?? json['short_bio'] ?? json['bio'],
      videoUrl:
          json['intro_video_url'] ?? json['intro_video'] ?? json['video_url'],

      // Adapt target_students to TargetAudience object structure
      targetAudience: json['target_students'] != null
          ? TargetAudience(
              gender: "جميع الفئات",
              levels: [json['target_students'] as String],
            )
          : (json['target_audience'] != null
                ? TargetAudience.fromJson(json['target_audience'])
                : null),

      // Adapt teaching_experience string to TeachingExperience list structure
      teachingExperiences: json['teaching_experience'] != null
          ? [
              TeachingExperience(
                country: "خبرة التدريس",
                countryFlag: null,
                duration: "",
                description: json['teaching_experience'] as String,
              ),
            ]
          : (json['teaching_experiences'] != null
                ? (json['teaching_experiences'] as List)
                      .map((i) => TeachingExperience.fromJson(i))
                      .toList()
                : null),

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
      subjects: json['subjects'] != null
          ? (json['subjects'] as List)
                .map((i) => TeacherSubject.fromJson(i))
                .toList()
          : null,
      availableTimeSlots: json['available_time_slots'] != null &&
              json['available_time_slots'] is List
          ? (json['available_time_slots'] as List)
                .map((i) => TeacherTimeSlot.fromJson(i))
                .toList()
          : null,
      availableTimeSlotsByDate: json['available_time_slots_by_date'] != null &&
              json['available_time_slots_by_date'] is Map
          ? (json['available_time_slots_by_date'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
                key,
                value is List
                    ? value.map((i) => TeacherTimeSlot.fromJson(i)).toList()
                    : [],
              ),
            )
          : null,

      // Raw new fields
      fullName: json['full_name'],
      specializationTitle: json['specialization_title'],
      location: json['location'],
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      yearsExperience: json['years_experience'],
      hourlyRate: (json['hourly_rate'] as num?)?.toDouble(),
      shortBio: json['short_bio'],
      about: json['about'],
      targetStudents: json['target_students'],
      teachingExperienceStr: json['teaching_experience'],
      introVideoUrl: json['intro_video_url'],
      introVideo: json['intro_video'],
      bookingPolicyHint: json['booking_policy_hint'],
    );
  }
}

class TeacherSubject {
  final int? id;
  final String? name;
  final double? hourlyRate;

  TeacherSubject({this.id, this.name, this.hourlyRate});

  factory TeacherSubject.fromJson(Map<String, dynamic> json) {
    return TeacherSubject(
      id: json['id'],
      name: json['name'],
      hourlyRate: (json['hourly_rate'] as num?)?.toDouble(),
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
      userName:
          json['user_name'] ??
          json['userName'] ??
          json['student_name'] ??
          (json['student'] is Map ? json['student']['full_name'] : null),
      userImage:
          json['user_image'] ??
          json['userImage'] ??
          (json['student'] is Map ? json['student']['image'] : null),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      comment: json['comment'] ?? json['review'] ?? "",
      date: json['date'] ?? json['created_at'] ?? "",
    );
  }
}

class TeacherTimeSlot {
  final int id;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final String? displayLabel;
  final bool? isBooked;

  TeacherTimeSlot({
    required this.id,
    this.date,
    this.startTime,
    this.endTime,
    this.displayLabel,
    this.isBooked,
  });

  factory TeacherTimeSlot.fromJson(Map<String, dynamic> json) {
    return TeacherTimeSlot(
      id: json['id'],
      date: json['date'] != null
          ? DateTime.tryParse(json['date'].toString())
          : null,
      startTime: json['start_time'],
      endTime: json['end_time'],
      displayLabel: json['display_label'],
      isBooked: json['is_booked'] == true || json['is_booked'] == 1,
    );
  }
}
