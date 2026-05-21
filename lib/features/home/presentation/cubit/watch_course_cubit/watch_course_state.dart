part of 'watch_course_cubit.dart';

@immutable
sealed class WatchCourseState {}

final class WatchCourseInitial extends WatchCourseState {}

class WatchCourseLoading extends WatchCourseState {}

class WatchCourseError extends WatchCourseState {
  final String message;

  WatchCourseError({required this.message});
}

class WatchCourseSuccess extends WatchCourseState {
  final WatchCourseResponse watchCourseResponse;

  WatchCourseSuccess({required this.watchCourseResponse});
}
