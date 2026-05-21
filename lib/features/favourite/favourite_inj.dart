import 'package:dr_nada_salma_med_edu_plat/features/favourite/data/favourite_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/data/favourite_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/favourite_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/usecases/add_to_favourite_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/usecases/fav_by_user_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/presentation/cubit/favourite_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> initFavouriteInj(GetIt s) async {
  s.registerFactory(() => FavouriteCubit(s(), s()));
  s.registerLazySingleton<FavouriteRemoteDataSource>(
    () => FavouriteRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton<FavouriteRepositories>(
    () => FavouritesRepositoryImpl(s()),
  );
  s.registerLazySingleton(() => AddToFavouriteUseCase(s()));
  s.registerLazySingleton(() => FavByUserUseCase(s()));
}
