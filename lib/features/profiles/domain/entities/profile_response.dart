class ProfileResponse {
  bool? status;
  String? message;
  Data? data;

  ProfileResponse({this.status, this.message, this.data});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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
  int? id;
  dynamic fullName;
  dynamic phoneNumber;
  dynamic countryCode;
  dynamic countrySymbol;
  dynamic email;
  dynamic totalPoints;
  dynamic totalStars;
  dynamic image;
  List<Specialties>? specialties;
  List<AcademicDegrees>? academicDegrees;

  // Teacher specific fields
  dynamic specializationTitle;
  dynamic country;
  dynamic city;
  List<String>? languages;
  dynamic studentsCount;
  dynamic yearsExperience;
  dynamic shortBio;
  dynamic about;
  dynamic targetStudents;
  dynamic teachingExperience;
  dynamic introVideoUrl;
  List<dynamic>? subjects;
  List<dynamic>? timeSlots;

  Data({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.email,
    this.totalPoints,
    this.totalStars,
    this.countryCode,
    this.countrySymbol,
    this.image,
    this.specialties,
    this.academicDegrees,
    this.specializationTitle,
    this.country,
    this.city,
    this.languages,
    this.studentsCount,
    this.yearsExperience,
    this.shortBio,
    this.about,
    this.targetStudents,
    this.teachingExperience,
    this.introVideoUrl,
    this.subjects,
    this.timeSlots,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    countryCode = json['country_code'];
    countrySymbol = json['country_symbol'];
    email = json['email'];
    totalPoints = json['total_points'];
    totalStars = json['total_stars'];
    image = json['image'];
    if (json['specialties'] != null) {
      specialties = <Specialties>[];
      json['specialties'].forEach((v) {
        specialties!.add(Specialties.fromJson(v));
      });
    }
    if (json['academic_degrees'] != null) {
      academicDegrees = <AcademicDegrees>[];
      json['academic_degrees'].forEach((v) {
        academicDegrees!.add(AcademicDegrees.fromJson(v));
      });
    }
    specializationTitle = json['specialization_title'];
    country = json['country'];
    city = json['city'];
    if (json['languages'] != null) {
      languages = List<String>.from(json['languages']);
    }
    studentsCount = json['students_count'];
    yearsExperience = json['years_experience'];
    shortBio = json['short_bio'];
    about = json['about'];
    targetStudents = json['target_students'];
    teachingExperience = json['teaching_experience'];
    introVideoUrl = json['intro_video_url'];
    if (json['subjects'] != null) {
      subjects = List<dynamic>.from(json['subjects']);
    }
    if (json['time_slots'] != null) {
      timeSlots = List<dynamic>.from(json['time_slots']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['phone_number'] = phoneNumber;
    data['email'] = email;
    data['total_points'] = totalPoints;
    data['total_stars'] = totalStars;
    data['image'] = image;
    if (specialties != null) {
      data['specialties'] = specialties!.map((v) => v.toJson()).toList();
    }
    if (academicDegrees != null) {
      data['academic_degrees'] = academicDegrees!
          .map((v) => v.toJson())
          .toList();
    }
    data['specialization_title'] = specializationTitle;
    data['country'] = country;
    data['city'] = city;
    data['languages'] = languages;
    data['students_count'] = studentsCount;
    data['years_experience'] = yearsExperience;
    data['short_bio'] = shortBio;
    data['about'] = about;
    data['target_students'] = targetStudents;
    data['teaching_experience'] = teachingExperience;
    data['intro_video_url'] = introVideoUrl;
    data['subjects'] = subjects;
    data['time_slots'] = timeSlots;
    return data;
  }
}

class Specialties {
  int? id;
  String? name;

  Specialties({this.id, this.name});

  Specialties.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class AcademicDegrees {
  int? id;
  String? name;

  AcademicDegrees({this.id, this.name});

  AcademicDegrees.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
