part of 'terms_cubit.dart';

@immutable
sealed class TermsState {}

final class TermsInitial extends TermsState {}


class TermsLoadingState extends TermsState {}

class TermsErrorState extends TermsState {
  final String message;

  TermsErrorState({required this.message});
}

class TermsSuccessState extends TermsState {
  final TermsConditionsResponse termsConditionsResponse;

  TermsSuccessState({required this.termsConditionsResponse});
}
