import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/profile_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class ProfileUseCase extends UseCase<ProfileResponse, NoParams> {
  final ProfileRepositories profileRepositories;

  ProfileUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, ProfileResponse>> call(NoParams params) async {
    return await profileRepositories.getProfile();
  }
}
