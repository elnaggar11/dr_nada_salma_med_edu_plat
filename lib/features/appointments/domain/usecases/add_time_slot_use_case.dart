import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';

class AddTimeSlotParams {
  final String date;
  final String startTime;
  final String endTime;

  AddTimeSlotParams({
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}

class AddTimeSlotUseCase {
  final AppointmentsRepository repository;

  AddTimeSlotUseCase(this.repository);

  Future<Either<Failure, TimeSlot>> call(AddTimeSlotParams params) async {
    return await repository.addTimeSlot(
      date: params.date,
      startTime: params.startTime,
      endTime: params.endTime,
    );
  }
}
