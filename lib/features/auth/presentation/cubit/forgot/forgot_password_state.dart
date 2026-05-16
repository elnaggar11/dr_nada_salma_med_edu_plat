part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}
class ForgotPasswordErrorState extends ForgotPasswordState {
  final String message;

  ForgotPasswordErrorState({required this.message});
}
class ForgotPasswordSuccessState extends ForgotPasswordState {
  final ForgotPasswordResponse forgotPasswordResponse;

  ForgotPasswordSuccessState({required this.forgotPasswordResponse});
}

class ForgotPasswordUpdateColorState extends ForgotPasswordState {}
