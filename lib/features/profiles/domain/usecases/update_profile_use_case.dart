import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/update_profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class UpdateProfileUseCase extends UseCase<UpdateProfileResponse,UpdateProfileParams>{
  final ProfileRepositories profileRepositories;

  UpdateProfileUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, UpdateProfileResponse>> call(UpdateProfileParams params)async {
    return await profileRepositories.updateProfile(params: params);
  }

}