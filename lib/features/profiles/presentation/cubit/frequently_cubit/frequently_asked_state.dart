part of 'frequently_asked_cubit.dart';

@immutable
sealed class FrequentlyAskedState {}

final class FrequentlyAskedInitial extends FrequentlyAskedState {}


class UpdateFrequentlyAskedExpandableState extends FrequentlyAskedState {}


class FrequentlyAskedLoading extends FrequentlyAskedState {}


class FrequentlyAskedErrorState extends FrequentlyAskedState {
  final String message;

  FrequentlyAskedErrorState({required this.message});
}
class FrequentlyAskedSuccessState extends FrequentlyAskedState {
  final FaqsResponse faqsResponse;

  FrequentlyAskedSuccessState({required this.faqsResponse});
}
