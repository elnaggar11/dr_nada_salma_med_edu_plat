import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/hero_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class HeroesUseCase extends UseCase<HeroResponse, NoParams> {
  final HomeRepositories homeRepositories;

  HeroesUseCase(this.homeRepositories);

  @override
  Future<Either<Failure, HeroResponse>> call(NoParams params) async {
    return await homeRepositories.getHeroes();
  }
}
