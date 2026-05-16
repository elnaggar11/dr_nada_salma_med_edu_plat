part of 'specialists_cubit.dart';

@immutable
sealed class SpecialistsState {}

final class SpecialistsInitial extends SpecialistsState {}

class SpecialistsLoadingState extends SpecialistsState {}

class SpecialistsErrorState extends SpecialistsState {
  final String msg;

  SpecialistsErrorState({required this.msg});
}

class SpecialistsSuccessState extends SpecialistsState {
  final SpecialistResponse specialistResponse;

  SpecialistsSuccessState({required this.specialistResponse});
}

class UpdateSpecialistCheckBox extends SpecialistsState {}


class UpdateAcademicDegreesCheckBox extends SpecialistsState {}

class UpdateSpecialistExpandableState extends SpecialistsState {}

class UpdateAcademicDegreeExpandableState extends SpecialistsState {}
