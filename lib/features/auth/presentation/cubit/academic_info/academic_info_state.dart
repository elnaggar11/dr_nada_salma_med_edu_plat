part of 'academic_info_cubit.dart';

@immutable
sealed class AcademicInfoState {}

final class AcademicInfoInitial extends AcademicInfoState {}

class AcademicInfoLoadingState extends AcademicInfoState {}

class AcademicInfoErrorState extends AcademicInfoState {
  final String message;

  AcademicInfoErrorState({required this.message});
}

class AcademicInfoSuccessState extends AcademicInfoState {
  final AcademicInfoResponse academicInfoResponse;

  AcademicInfoSuccessState({required this.academicInfoResponse});
}
