import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/settings_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class SettingsUseCase extends UseCase<SettingsResponse,NoParams>{
  final ProfileRepositories profileRepositories;

  SettingsUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, SettingsResponse>> call(NoParams params) async{
    return await profileRepositories.getSettings();
  }

}