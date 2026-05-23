import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/subject_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class GetSubjectsUseCase extends UseCase<SubjectResponse, NoParams> {
  final AuthRepositories repository;

  GetSubjectsUseCase(this.repository);

  @override
  Future<Either<Failure, SubjectResponse>> call(NoParams params) async {
    return await repository.getSubjects();
  }
}
