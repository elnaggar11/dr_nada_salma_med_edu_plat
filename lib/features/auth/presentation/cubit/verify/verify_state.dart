part of 'verify_cubit.dart';

@immutable
sealed class VerifyState {}

final class VerifyInitial extends VerifyState {}


class UpdateVerifyState extends VerifyState {}


class VerifyOtpLoadingState extends VerifyState {}

class VerifyErrorState extends VerifyState {
  final String message;

  VerifyErrorState({required this.message});
}

class VerifyOtpSuccessState extends VerifyState {
  final VerifyOtpResponse verifyOtpResponse;

  VerifyOtpSuccessState({required this.verifyOtpResponse});
}

class UpdateTimerState extends VerifyState {}