import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/certificate_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class CertificateUseCase extends UseCase<CertificateResponse,NoParams>{
  final ProfileRepositories profileRepositories;

  CertificateUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, CertificateResponse>> call(NoParams params) async{
   return await profileRepositories.getCertificates();
  }

}