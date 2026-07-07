part of 'courses_details_cubit.dart';

@immutable
sealed class CoursesDetailsState {}

final class CoursesDetailsInitial extends CoursesDetailsState {}

class CoursesDetailsLoadingState extends CoursesDetailsState {}

class CoursesDetailsErrorState extends CoursesDetailsState {
  final String message;

  CoursesDetailsErrorState({required this.message});
}

class CoursesDetailsSuccessState extends CoursesDetailsState {
  final CoursesDetailsResponse coursesDetailsResponse;

  CoursesDetailsSuccessState({required this.coursesDetailsResponse});
}

class CourseBookingLoadingState extends CoursesDetailsState {}

class CourseBookingSuccessState extends CoursesDetailsState {
  final String message;
  CourseBookingSuccessState({required this.message});
}

class CourseBookingErrorState extends CoursesDetailsState {
  final String message;
  CourseBookingErrorState({required this.message});
}
