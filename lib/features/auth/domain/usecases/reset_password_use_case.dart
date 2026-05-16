import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class ResetPasswordUseCase extends UseCase<ResetPasswordResponse,ResetPasswordParams>{
  final AuthRepositories authRepositories;

  ResetPasswordUseCase(this.authRepositories);

  @override
  Future<Either<Failure, ResetPasswordResponse>> call(ResetPasswordParams params)async {
    return await authRepositories.reset(params: params);
  }

}