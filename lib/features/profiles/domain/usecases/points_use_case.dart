import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/data/profile_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/points_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class PointsUseCase extends UseCase<PointsResponse,NoParams>{
  final ProfileRepositories profileRepositories;

  PointsUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, PointsResponse>> call(NoParams params) async{
    return await profileRepositories.getPoints();
  }

}