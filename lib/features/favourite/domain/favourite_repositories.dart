import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/add_to_favourite_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourite_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourtie_response.dart';

abstract class FavouriteRepositories {
  Future<Either<Failure, AddToFavouriteResponse>> addToFavourite({
    FavouriteParams params,
  });
  Future<Either<Failure, FavouriteResponse>> getMyFavourites();
}
