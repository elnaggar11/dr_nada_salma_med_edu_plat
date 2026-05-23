part of 'reset_pass_cubit.dart';

@immutable
sealed class ResetPassState {}

final class ResetPassInitial extends ResetPassState {}

class ResetPasswordLoadingState extends ResetPassState {}

class ResetPasswordErrorState extends ResetPassState {
  final String message;

  ResetPasswordErrorState({required this.message});
}

class ResetPasswordSuccessState extends ResetPassState {
  final ResetPasswordResponse resetPasswordResponse;

  ResetPasswordSuccessState({required this.resetPasswordResponse});
}

class ResetUpdateVisibilityState extends ResetPassState {}

class UpdateConfirmationPasswordVisibilityState extends ResetPassState {}
