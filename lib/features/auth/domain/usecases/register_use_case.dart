import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class RegisterUseCase extends UseCase<RegisterResponse,RegisterParams>{
  final AuthRepositories authRepositories;

  RegisterUseCase(this.authRepositories);

  @override
  Future<Either<Failure, RegisterResponse>> call(RegisterParams params) async{
   return await authRepositories.register(params: params);
  }


}