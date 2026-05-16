import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/about_us_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class AboutUsUseCase extends UseCase<AboutUsResponse,NoParams>{
  final ProfileRepositories profileRepositories;

  AboutUsUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, AboutUsResponse>> call(NoParams params) async{
    return await profileRepositories.getAboutUs();
  }

}