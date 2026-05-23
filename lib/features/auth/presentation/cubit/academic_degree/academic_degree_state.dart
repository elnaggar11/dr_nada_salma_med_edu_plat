part of 'academic_degree_cubit.dart';

@immutable
sealed class AcademicDegreeState {}

final class AcademicDegreeInitial extends AcademicDegreeState {}

class AcademicDegreeSuccessState extends AcademicDegreeState {
  final AcademicDegreeResponse academicDegreeResponse;

  AcademicDegreeSuccessState({required this.academicDegreeResponse});
}

class AcademicDegreeErrorState extends AcademicDegreeState {
  final String msg;

  AcademicDegreeErrorState({required this.msg});
}

class AcademicDegreeLoadingState extends AcademicDegreeState {}

class UpdateAcademicDegreesCheckBox extends AcademicDegreeState {}

class UpdateSpecialistExpandableState extends AcademicDegreeState {}

class UpdateAcademicDegreeExpandableState extends AcademicDegreeState {}
