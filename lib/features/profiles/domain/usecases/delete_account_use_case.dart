import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/delete_account_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/repositories/profile_repositories.dart';

class DeleteAccountUseCase extends UseCase<DeleteAccountResponse,NoParams>{
  final ProfileRepositories profileRepositories;

  DeleteAccountUseCase(this.profileRepositories);

  @override
  Future<Either<Failure, DeleteAccountResponse>> call(NoParams params)async {
    return await profileRepositories.deleteAccount();
  }

}