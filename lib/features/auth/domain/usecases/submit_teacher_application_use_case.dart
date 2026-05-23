import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/teacher_registration/teacher_application_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class SubmitTeacherApplicationUseCase extends UseCase<TeacherApplicationResponse, TeacherApplicationParams> {
  final AuthRepositories repository;

  SubmitTeacherApplicationUseCase(this.repository);

  @override
  Future<Either<Failure, TeacherApplicationResponse>> call(TeacherApplicationParams params) async {
    return await repository.submitTeacherApplication(params: params);
  }
}
