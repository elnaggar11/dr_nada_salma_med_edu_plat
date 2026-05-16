import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class SuccessStoriesUseCase extends UseCase<SuccessStoriesResponse,NoParams>{
  final HomeRepositories homeRepositories;

  SuccessStoriesUseCase(this.homeRepositories);

  @override
  Future<Either<Failure, SuccessStoriesResponse>> call(NoParams params) async{
   return await homeRepositories.getSuccessStories();
  }

}