part of 'public_courses_cubit.dart';

@immutable
abstract class PublicCoursesState {}

class PublicCoursesInitialState extends PublicCoursesState {}

class PublicCoursesLoadingState extends PublicCoursesState {}

class PublicCoursesLoading extends PublicCoursesState {
  final List<Data> previousCourses;
  final bool isFirstFetch;

  PublicCoursesLoading(this.previousCourses, {this.isFirstFetch = false});
}

class PublicCoursesLoaded extends PublicCoursesState {
  final List<Data> courses;
  final bool hasReachedMax; // true if no more pages

  PublicCoursesLoaded({required this.courses, this.hasReachedMax = false});
}

class PublicCoursesError extends PublicCoursesState {
  final String message;
  PublicCoursesError(this.message);
}

class ResetCoursesLoading extends PublicCoursesState {}

class ResetCoursesError extends PublicCoursesState {
  final String message;
  ResetCoursesError({required this.message});
}

class ResetCoursesSuccessState extends PublicCoursesState {
  final PublicCoursesResponse publicCoursesResponse;

  ResetCoursesSuccessState({required this.publicCoursesResponse});
}
