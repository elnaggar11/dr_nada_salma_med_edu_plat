part of 'success_stories_cubit.dart';

@immutable
sealed class SuccessStoriesState {}

final class SuccessStoriesInitial extends SuccessStoriesState {}

class SuccessStoriesLoadingState extends SuccessStoriesState {}

class SuccessStoriesErrorState extends SuccessStoriesState {
  final String message;

  SuccessStoriesErrorState({required this.message});
}

class SuccessStoriesSuccessState extends SuccessStoriesState {
  final SuccessStoriesResponse successStoriesResponse;

  SuccessStoriesSuccessState({required this.successStoriesResponse});
}
