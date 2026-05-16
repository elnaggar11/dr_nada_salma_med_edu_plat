import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class ResendOtpUseCase extends UseCase<ResendOtpResponse,ResendOtpParams>{
  final AuthRepositories authRepositories;

  ResendOtpUseCase(this.authRepositories);

  @override
  Future<Either<Failure, ResendOtpResponse>> call(ResendOtpParams params)async {
    return await authRepositories.resendOtp(params: params);
  }

}