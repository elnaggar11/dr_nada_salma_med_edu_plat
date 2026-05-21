import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class ForgotPasswordUseCase
    extends UseCase<ForgotPasswordResponse, ForgotPasswordParams> {
  final AuthRepositories authRepositories;

  ForgotPasswordUseCase(this.authRepositories);

  @override
  Future<Either<Failure, ForgotPasswordResponse>> call(
    ForgotPasswordParams params,
  ) async {
    return await authRepositories.forgotPassword(params: params);
  }
}
