import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/terms_conditions_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class TermsConditionsUseCase
    extends UseCase<TermsConditionsResponse, NoParams> {
  final ProfileRepositories profileRepositories;

  TermsConditionsUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, TermsConditionsResponse>> call(NoParams params) async {
    return await profileRepositories.getTermsConditions();
  }
}
