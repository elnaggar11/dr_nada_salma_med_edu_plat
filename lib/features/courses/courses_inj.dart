import 'package:dr_nada_salma_med_edu_plat/features/courses/data/courses_remote_data_sources_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/data/courses_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/usecases/categories_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/usecases/courses_status_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/categories/categories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/courses_status_cubit/courses_status_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teacher_detail/teacher_detail_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/teachers/teachers_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> coursesInj(GetIt s) async {
  s.registerFactory(() => CategoriesCubit(s()));
  s.registerFactory(() => CoursesStatusCubit(s()));
  s.registerFactory(() => TeacherDetailCubit(s()));
  s.registerFactory(() => TeachersCubit(s()));
  s.registerLazySingleton(() => CategoriesUseCase(s()));
  s.registerLazySingleton(() => CoursesStatusUseCase(s()));
  s.registerLazySingleton<CoursesRemoteDataSource>(
    () => CoursesRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton<CoursesRepositories>(
    () => CoursesRepositoryImpl(s()),
  );
}
