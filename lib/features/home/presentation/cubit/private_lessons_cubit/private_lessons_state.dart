part of 'private_lessons_cubit.dart';

@immutable
sealed class PrivateLessonsState {}

final class PrivateLessonsInitial extends PrivateLessonsState {}

class PrivateLessonsLoadingState extends PrivateLessonsState {}


class PrivateLessonsErrorState extends PrivateLessonsState {
  final String message;

  PrivateLessonsErrorState({required this.message});
}

class PrivateLessonsSuccessState extends PrivateLessonsState {
  final PublicCoursesResponse publicCoursesResponse;

  PrivateLessonsSuccessState({required this.publicCoursesResponse});
}