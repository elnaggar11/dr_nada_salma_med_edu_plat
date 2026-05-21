import 'package:dr_nada_salma_med_edu_plat/features/notifications/data/notification_remote_data_source_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/data/notification_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/repositories/notifications_repositories.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/domain/usecase/notifications_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> notificationsInj(GetIt s) async {
  s.registerFactory(() => NotificationsCubit(s()));
  s.registerLazySingleton<NotificationsRepositories>(
    () => NotificationsRepositoryImpl(s()),
  );
  s.registerLazySingleton<NotificationsRemoteDataSource>(
    () => NotificationsRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton(() => NotificationsUseCase(s()));
}
