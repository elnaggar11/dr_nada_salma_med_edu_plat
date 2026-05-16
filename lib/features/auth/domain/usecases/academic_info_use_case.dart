import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/repositories/auth_repositories.dart';

class AcademicInfoUseCase extends UseCase<AcademicInfoResponse,AcademicInfoParams>{
  final AuthRepositories authRepositories;

  AcademicInfoUseCase(this.authRepositories);

  @override
  Future<Either<Failure, AcademicInfoResponse>> call(AcademicInfoParams params) async{
    return await authRepositories.setAcademicInfo(params: params);
  }

}