part of 'notifications_cubit.dart';

@immutable
sealed class NotificationsState {}

final class NotificationsInitial extends NotificationsState {}

class NotificationsLoadingState extends NotificationsState {}

class NotificationsErrorState extends NotificationsState {
  final String message;

  NotificationsErrorState({required this.message});
}

class NotificationsSuccessState extends NotificationsState {
  final NotificationsResponse notificationsResponse;

  NotificationsSuccessState({required this.notificationsResponse});
}
