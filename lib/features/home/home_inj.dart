import 'package:dr_nada_salma_med_edu_plat/features/home/data/home_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/data/home_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/repositories/home_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/courses_details_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/heroes_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/private_lessons_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/public_courses_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/success_stories_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/watch_course_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/courses_details_cubit/courses_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/hero/heroes_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/private_lessons_cubit/private_lessons_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/public_courses/public_courses_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/success_stories/success_stories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/watch_course_cubit/watch_course_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void>initHomeInj(GetIt s)async{
  s.registerFactory(()=> SuccessStoriesCubit(s()));
  s.registerFactory(()=>HeroesCubit(s()));
  s.registerFactory(()=> PublicCoursesCubit(s()));
  s.registerFactory(()=> PrivateLessonsCubit(s()));
  s.registerFactory(()=> CoursesDetailsCubit(s()));
  s.registerFactory(()=> WatchCourseCubit(s()));
  s.registerLazySingleton(()=> WatchCourseUseCase(s()));
  s.registerLazySingleton<HomeRemoteDataSource>(()=>HomeRemoteDataSourceImpl(s()));
  s.registerLazySingleton<HomeRepositories>(()=>HomeRepositoryImpl(s()));
  s.registerLazySingleton(()=> SuccessStoriesUseCase(s()));
  s.registerLazySingleton(()=> HeroesUseCase(s()));
  s.registerLazySingleton(()=>PublicCoursesUseCase(s()));
  s.registerLazySingleton(()=> CoursesDetailsUseCase(s()));
  s.registerLazySingleton(()=> PrivateLessonsUseCase(s()));
}