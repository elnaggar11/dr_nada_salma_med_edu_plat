import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

class CoursesStatusUseCase extends UseCase<CoursesStatusResponse,CoursesStatusParams>{
  final CoursesRepositories coursesRepositories;

  CoursesStatusUseCase(this.coursesRepositories);

  @override
  Future<Either<Failure, CoursesStatusResponse>> call(CoursesStatusParams params)async {
    return await coursesRepositories.getCoursesStatus(params: params);
  }

}