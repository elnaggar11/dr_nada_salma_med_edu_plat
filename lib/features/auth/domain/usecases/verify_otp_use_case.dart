import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class VerifyOtpUseCase extends UseCase<VerifyOtpResponse, VerifyOtpParams> {
  final AuthRepositories authRepositories;

  VerifyOtpUseCase(this.authRepositories);

  @override
  Future<Either<Failure, VerifyOtpResponse>> call(
    VerifyOtpParams params,
  ) async {
    return await authRepositories.verifyOtp(params: params);
  }
}
