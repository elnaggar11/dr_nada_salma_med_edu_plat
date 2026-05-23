import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/faqs_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class FaqsUseCase extends UseCase<FaqsResponse, NoParams> {
  final ProfileRepositories profileRepositories;

  FaqsUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, FaqsResponse>> call(NoParams params) async {
    return await profileRepositories.getFaqs();
  }
}
