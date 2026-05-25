import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';

class DeleteTimeSlotUseCase {
  final AppointmentsRepository repository;

  DeleteTimeSlotUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteTimeSlot(id);
  }
}
