import 'package:dr_nada_salma_med_edu_plat/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:get_it/get_it.dart';

Future<void> appointmentsInj(GetIt s) async {
  s.registerFactory(() => AppointmentsCubit());
}
