import 'dart:io';

class UpdateProfileParams {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;
  List<int>? specialties;
  List<int>? academicDegrees;
  File? img;

  // Teacher specific fields
  String? specializationTitle;
  String? country;
  String? city;
  List<String>? languages;
  int? studentsCount;
  int? yearsExperience;
  String? shortBio;
  String? about;
  String? targetStudents;
  String? teachingExperience;
  String? introVideoUrl;
  List<Map<String, dynamic>>? subjects;
  List<Map<String, dynamic>>? timeSlots;
  List<int>? removeTimeSlotIds;

  UpdateProfileParams({
    this.fullName,
    this.phoneNumber,
    this.email,
    this.password,
    this.specialties,
    this.academicDegrees,
    this.img,
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
    this.removeTimeSlotIds,
  });
}
