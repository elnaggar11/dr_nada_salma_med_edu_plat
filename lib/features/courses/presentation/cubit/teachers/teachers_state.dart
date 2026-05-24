part of 'teachers_cubit.dart';

enum TeachersRequestState { initial, loading, success, error }

class TeachersState {
  final TeachersRequestState status;
  final String? message;
  final List<TeacherItem> teachers;
  final String searchQuery;
  final int? selectedSpecialtyId;
  final double minPrice;
  final double maxPrice;
  final SubjectDetailsResponse? subjectDetails;
  final bool loadingSubjectDetails;

  TeachersState({
    this.status = TeachersRequestState.initial,
    this.message,
    this.teachers = const [],
    this.searchQuery = "",
    this.selectedSpecialtyId,
    this.minPrice = 0.0,
    this.maxPrice = 500.0,
    this.subjectDetails,
    this.loadingSubjectDetails = false,
  });

  TeachersState copyWith({
    TeachersRequestState? status,
    String? message,
    List<TeacherItem>? teachers,
    String? searchQuery,
    int? selectedSpecialtyId,
    double? minPrice,
    double? maxPrice,
    SubjectDetailsResponse? subjectDetails,
    bool? loadingSubjectDetails,
    bool clearSpecialty = false,
  }) {
    return TeachersState(
      status: status ?? this.status,
      message: message ?? this.message,
      teachers: teachers ?? this.teachers,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedSpecialtyId: clearSpecialty ? null : (selectedSpecialtyId ?? this.selectedSpecialtyId),
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      subjectDetails: subjectDetails ?? this.subjectDetails,
      loadingSubjectDetails: loadingSubjectDetails ?? this.loadingSubjectDetails,
    );
  }
}
