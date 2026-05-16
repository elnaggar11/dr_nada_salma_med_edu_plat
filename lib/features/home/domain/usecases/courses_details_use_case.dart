import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class CoursesDetailsUseCase extends UseCase<CoursesDetailsResponse,CoursesDetailsParams>{
  final HomeRepositories homeRepositories;

  CoursesDetailsUseCase(this.homeRepositories);

  @override
  Future<Either<Failure, CoursesDetailsResponse>> call(CoursesDetailsParams params) async{
   return await homeRepositories.getCoursesDetails(params: params);
  }

}