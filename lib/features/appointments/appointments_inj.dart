import 'package:dr_nada_salma_med_edu_plat/features/appointments/data/datasources/appointments_remote_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/data/repositories/appointments_repository_impl.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/add_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/delete_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/fetch_time_slots_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/usecases/update_time_slot_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> appointmentsInj(GetIt s) async {
  // Remote Data Source
  s.registerLazySingleton<AppointmentsRemoteDataSource>(
    () => AppointmentsRemoteDataSourceImpl(s()),
  );

  // Repository
  s.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepositoryImpl(s()),
  );

  // Use Cases
  s.registerLazySingleton(() => FetchTimeSlotsUseCase(s()));
  s.registerLazySingleton(() => AddTimeSlotUseCase(s()));
  s.registerLazySingleton(() => UpdateTimeSlotUseCase(s()));
  s.registerLazySingleton(() => DeleteTimeSlotUseCase(s()));

  // Cubit
  s.registerFactory(
    () => AppointmentsCubit(
      fetchTimeSlotsUseCase: s(),
      addTimeSlotUseCase: s(),
      updateTimeSlotUseCase: s(),
      deleteTimeSlotUseCase: s(),
    ),
  );
}
