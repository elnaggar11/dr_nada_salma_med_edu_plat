import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/log_out_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class LogOutUseCase extends UseCase<LogOutResponse, NoParams> {
  final ProfileRepositories profileRepositories;

  LogOutUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, LogOutResponse>> call(NoParams params) async {
    return await profileRepositories.logOut();
  }
}
