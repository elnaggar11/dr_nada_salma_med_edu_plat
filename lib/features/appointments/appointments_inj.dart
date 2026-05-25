import 'package:dr_nada_salma_med_edu_plat/features/appointments/data/datasources/appointments_remote_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/data/repositories/appointments_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> appointmentsInj(GetIt s) async {
  s.registerFactory(() => AppointmentsCubit(s()));
  s.registerLazySingleton<AppointmentsRemoteDataSource>(
    () => AppointmentsRemoteDataSourceImpl(s()),
  );
  s.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(s()),
  );
}

