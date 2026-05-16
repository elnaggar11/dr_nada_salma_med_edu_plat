part of 'heroes_cubit.dart';

@immutable
sealed class HeroesState {}

final class HeroesInitial extends HeroesState {}


class HeroesLoadingState extends HeroesState {}


class HeroesErrorState extends HeroesState {
  final String message;

  HeroesErrorState({required this.message});
}
class HeroesSuccessState extends HeroesState {
  final HeroResponse heroResponse;

  HeroesSuccessState({required this.heroResponse});
}