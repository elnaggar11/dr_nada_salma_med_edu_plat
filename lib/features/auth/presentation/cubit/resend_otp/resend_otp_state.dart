part of 'resend_otp_cubit.dart';

@immutable
sealed class ResendOtpState {}

final class ResendOtpInitial extends ResendOtpState {}

class ResendOtpLoadingState extends ResendOtpState {}

class ResendOtpErrorState extends ResendOtpState {
  final String message;

  ResendOtpErrorState({required this.message});
}

class ResendOtpSuccessState extends ResendOtpState {
  final ResendOtpResponse response;

  ResendOtpSuccessState({required this.response});
}
