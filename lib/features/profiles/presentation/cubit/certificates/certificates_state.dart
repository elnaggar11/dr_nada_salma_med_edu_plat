part of 'certificates_cubit.dart';

@immutable
sealed class CertificatesState {}

final class CertificatesInitial extends CertificatesState {}


class CertificatesLoadingState extends CertificatesState {}


class CertificatesErrorState extends CertificatesState {
  final String msg;

  CertificatesErrorState({required this.msg});
}
class CertificatesSuccessState extends CertificatesState {
  final CertificateResponse certificateResponse;

  CertificatesSuccessState({required this.certificateResponse});
}
