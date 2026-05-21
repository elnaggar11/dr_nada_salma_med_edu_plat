part of 'points_cubit.dart';

@immutable
sealed class PointsState {}

final class PointsInitial extends PointsState {}

class PointsLoadingState extends PointsState {}

class PointsErrorState extends PointsState {
  final String message;

  PointsErrorState({required this.message});
}

class PointsSuccessState extends PointsState {
  final PointsResponse pointsResponse;

  PointsSuccessState({required this.pointsResponse});
}
