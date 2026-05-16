import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/add_to_favourite_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourite_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/favourite_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/usecases/add_to_favourite_use_case.dart';

class AddToFavouriteUseCase implements UseCase<AddToFavouriteResponse,FavouriteParams>{
  final FavouriteRepositories repository;

  AddToFavouriteUseCase(this.repository);

  @override
  Future<Either<Failure, AddToFavouriteResponse>> call(FavouriteParams params) async{
    return await repository.addToFavourite(params: params);
  }

}
