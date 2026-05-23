import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class PublicCoursesUseCase
    extends UseCase<PublicCoursesResponse, CoursesParams> {
  final HomeRepositories homeRepositories;

  PublicCoursesUseCase(this.homeRepositories);

  @override
  Future<Either<Failure, PublicCoursesResponse>> call(
    CoursesParams params,
  ) async {
    return await homeRepositories.getCourses(params: params);
  }
}
