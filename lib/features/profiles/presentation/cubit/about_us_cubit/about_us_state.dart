part of 'about_us_cubit.dart';

@immutable
sealed class AboutUsState {}

final class AboutUsInitial extends AboutUsState {}

class AboutUsLoadingState extends AboutUsState {}

class AboutUsErrorState extends AboutUsState {
  final String message;

  AboutUsErrorState({required this.message});
}

class AboutUsSuccessState extends AboutUsState {
  final AboutUsResponse aboutUsResponse;

  AboutUsSuccessState({required this.aboutUsResponse});
}
