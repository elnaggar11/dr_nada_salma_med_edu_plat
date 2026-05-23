class TeacherApplicationParams {
  final String name;
  final String email;
  final int specialtyId;
  final String bio;
  final List<int> subjectIds;
  final String whatsapp;
  final String? alternativeContact;
  final List<String> availableDays;
  final String fromTime;
  final String toTime;

  TeacherApplicationParams({
    required this.name,
    required this.email,
    required this.specialtyId,
    required this.bio,
    required this.subjectIds,
    required this.whatsapp,
    this.alternativeContact,
    required this.availableDays,
    required this.fromTime,
    required this.toTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'specialty_id': specialtyId,
      'bio': bio,
      'subjects': subjectIds,
      'whatsapp': whatsapp,
      if (alternativeContact != null && alternativeContact!.isNotEmpty)
        'alternative_contact': alternativeContact,
      'available_days': availableDays,
      'from_time': fromTime,
      'to_time': toTime,
    };
  }
}
