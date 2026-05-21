import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class CheckOtpUseCase extends UseCase<CheckOtpResponse, CheckOtpParams> {
  final AuthRepositories authRepositories;

  CheckOtpUseCase(this.authRepositories);

  @override
  Future<Either<Failure, CheckOtpResponse>> call(CheckOtpParams params) async {
    return await authRepositories.checkOtp(params: params);
  }
}
