import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

class CategoriesUseCase extends UseCase<CategoriesResponse, NoParams> {
  final CoursesRepositories coursesRepositories;

  CategoriesUseCase(this.coursesRepositories);

  @override
  Future<Either<Failure, CategoriesResponse>> call(NoParams params) async {
    return await coursesRepositories.getCategories();
  }
}
