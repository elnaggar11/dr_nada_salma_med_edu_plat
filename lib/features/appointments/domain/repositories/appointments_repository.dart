import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';

abstract class AppointmentsRepository {
  Future<Either<Failure, TimeSlotResponse>> getTimeSlots();
  Future<Either<Failure, Map<String, dynamic>>> deleteTimeSlot(int id);
  Future<Either<Failure, TimeSlot>> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  });
  Future<Either<Failure, TimeSlot>> updateTimeSlot({
    required int id,
    required String date,
    required String startTime,
    required String endTime,
  });
}

