part of 'courses_status_cubit.dart';

@immutable
sealed class CoursesStatusState {}

final class CoursesStatusInitial extends CoursesStatusState {}


class CoursesStatusLoadingState extends CoursesStatusState {}


class CoursesStatusErrorState extends CoursesStatusState {
  final String message;

  CoursesStatusErrorState({required this.message});
}
class CoursesStatusSuccessState extends CoursesStatusState {
  final CoursesStatusResponse coursesStatusResponse;

  CoursesStatusSuccessState({required this.coursesStatusResponse});
}
class UpdateCoursesTabState extends CoursesStatusState {}