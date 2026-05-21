class AcademicInfoParams {
  String? email;
  dynamic specialists;
  dynamic academicDegrees;

  AcademicInfoParams({this.email, this.specialists, this.academicDegrees});

  Map<String, dynamic> toMap() {
    return {
      "email": email,
      "specialties[]": specialists.toString(),
      "academic_degrees[]": academicDegrees.toString(),
    };
  }
}
