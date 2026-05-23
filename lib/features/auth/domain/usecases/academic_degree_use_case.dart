import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_degree/academic_degree_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class AcademicDegreeUseCase extends UseCase<AcademicDegreeResponse, NoParams> {
  final AuthRepositories authRepositories;

  AcademicDegreeUseCase(this.authRepositories);

  @override
  Future<Either<Failure, AcademicDegreeResponse>> call(NoParams params) async {
    return await authRepositories.getAcademicDegrees();
  }
}
