import 'package:dr_nada_salma_med_edu_plat/features/blog/data/blog_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/data/blog_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/repositories/blog_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/blog_by_category_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/categories_with_blog_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/domain/usecase/social_media_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/blog_details_cubit/blog_details_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/blog/presentation/cubit/category_with_blog/category_with_blog_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void>initBlogInj(GetIt s)async{
 s.registerFactory(()=> CategoryWithBlogCubit(s()));
 s.registerFactory(()=> BlogDetailsCubit(s(),s()));
 s.registerLazySingleton(()=>SocialMediaUseCase(s()));
 s.registerLazySingleton<BlogRemoteDataSource>(()=> BlogRemoteDataSourceImpl(s()));
 s.registerLazySingleton<BlogsRepositories>(()=> BlogRepositoriesImpl(s()));
 s.registerLazySingleton(()=> CategoriesWithBlogUseCase(s()));
 s.registerLazySingleton(()=> BlogByCategoryUseCase(s()));
}