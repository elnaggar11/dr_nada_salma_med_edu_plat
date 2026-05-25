import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';

class UpdateTimeSlotParams {
  final int id;
  final String date;
  final String startTime;
  final String endTime;

  UpdateTimeSlotParams({
    required this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
}

class UpdateTimeSlotUseCase {
  final AppointmentsRepository repository;

  UpdateTimeSlotUseCase(this.repository);

  Future<Either<Failure, TimeSlot>> call(UpdateTimeSlotParams params) async {
    return await repository.updateTimeSlot(
      id: params.id,
      date: params.date,
      startTime: params.startTime,
      endTime: params.endTime,
    );
  }
}
