import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/specialists/specialist_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class SpecialistUseCase extends UseCase<SpecialistResponse, NoParams> {
  final AuthRepositories authRepositories;

  SpecialistUseCase(this.authRepositories);

  @override
  Future<Either<Failure, SpecialistResponse>> call(NoParams params) async {
    return await authRepositories.getSpecialists();
  }
}
