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

  Data(
      {this.id,
        this.fullName,
        this.phoneNumber,
        this.email,
        this.totalPoints,
        this.totalStars,
        this.countryCode,
        this.countrySymbol,
        this.image,
        this.specialties,
        this.academicDegrees});

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
      data['academic_degrees'] =
          academicDegrees!.map((v) => v.toJson()).toList();
    }
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