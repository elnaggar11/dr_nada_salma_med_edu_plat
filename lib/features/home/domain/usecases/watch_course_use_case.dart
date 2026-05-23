import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';

class WatchCourseUseCase
    extends UseCase<WatchCourseResponse, WatchCourseParams> {
  final HomeRepositories homeRepositories;

  WatchCourseUseCase(this.homeRepositories);

  @override
  Future<Either<Failure, WatchCourseResponse>> call(
    WatchCourseParams params,
  ) async {
    return await homeRepositories.watchCourse(params: params);
  }
}
