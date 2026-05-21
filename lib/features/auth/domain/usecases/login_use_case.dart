import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginParams> {
  final AuthRepositories authRepositories;

  LoginUseCase(this.authRepositories);

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await authRepositories.login(params: params);
  }
}
