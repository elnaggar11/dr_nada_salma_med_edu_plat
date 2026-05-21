part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final AddToFavouriteResponse? response;

  FavouriteSuccess({required this.response});
}

class FavouritesByUserSuccess extends FavouriteState {
  final FavouriteResponse? response;

  FavouritesByUserSuccess({required this.response});
}

class FavouriteError extends FavouriteState {
  final String? message;

  FavouriteError({required this.message});
}

class FavouriteFailure extends FavouriteState {}

class AddFavouriteChange extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<Data> adsDatumList;

  FavouriteLoaded({required this.adsDatumList});

  @override
  List<Object> get props => adsDatumList;
}

class LoadingFavourite extends FavouriteState {}

class AddFavouriteLoading extends FavouriteState {}

class InitFavouriteList extends FavouriteState {}
