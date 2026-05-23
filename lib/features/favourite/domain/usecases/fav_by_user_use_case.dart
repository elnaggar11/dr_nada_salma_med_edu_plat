import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourtie_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/favourite_repositories.dart';

class FavByUserUseCase implements UseCase<FavouriteResponse, NoParams> {
  final FavouriteRepositories repository;

  FavByUserUseCase(this.repository);

  @override
  Future<Either<Failure, FavouriteResponse>> call(NoParams params) async {
    return await repository.getMyFavourites();
  }
}
