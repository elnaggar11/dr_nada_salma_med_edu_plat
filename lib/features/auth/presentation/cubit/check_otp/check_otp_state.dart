part of 'check_otp_cubit.dart';

@immutable
sealed class CheckOtpState {}

final class CheckOtpInitial extends CheckOtpState {}

class CheckOtpLoading extends CheckOtpState {}

class CheckOtpError extends CheckOtpState {
  final String msg;

  CheckOtpError({required this.msg});
}

class CheckOtpSuccess extends CheckOtpState {
  final CheckOtpResponse checkOtpResponse;

  CheckOtpSuccess({required this.checkOtpResponse});
}
