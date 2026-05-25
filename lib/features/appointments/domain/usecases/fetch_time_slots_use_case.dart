import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';

class FetchTimeSlotsUseCase extends UseCase<List<TimeSlot>, NoParams> {
  final AppointmentsRepository repository;

  FetchTimeSlotsUseCase(this.repository);

  @override
  Future<Either<Failure, List<TimeSlot>>> call(NoParams params) async {
    return await repository.fetchTimeSlots();
  }
}
