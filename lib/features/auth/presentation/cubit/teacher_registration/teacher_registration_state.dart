part of 'teacher_registration_cubit.dart';

@immutable
sealed class TeacherRegistrationState {}

final class TeacherRegistrationInitial extends TeacherRegistrationState {}

class TeacherRegistrationLoadingDataState extends TeacherRegistrationState {}

class TeacherRegistrationDataLoadedState extends TeacherRegistrationState {}

class TeacherRegistrationDataErrorState extends TeacherRegistrationState {
  final String msg;
  TeacherRegistrationDataErrorState({required this.msg});
}

class TeacherRegistrationSubmitLoadingState extends TeacherRegistrationState {}

class TeacherRegistrationSubmitSuccessState extends TeacherRegistrationState {
  final TeacherApplicationResponse response;
  TeacherRegistrationSubmitSuccessState({required this.response});
}

class TeacherRegistrationSubmitErrorState extends TeacherRegistrationState {
  final String msg;
  TeacherRegistrationSubmitErrorState({required this.msg});
}

class TeacherRegistrationUpdateUIState extends TeacherRegistrationState {}
