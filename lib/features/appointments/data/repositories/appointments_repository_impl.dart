import 'package:dartz/dartz.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/data/datasources/appointments_remote_data_source.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/repositories/appointments_repository.dart';

class AppointmentsRepositoryImpl implements AppointmentsRepository {
  final AppointmentsRemoteDataSource remoteDataSource;

  AppointmentsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, TimeSlotResponse>> getTimeSlots() async {
    try {
      final response = await remoteDataSource.getTimeSlots();
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> deleteTimeSlot(int id) async {
    try {
      final response = await remoteDataSource.deleteTimeSlot(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TimeSlot>> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await remoteDataSource.addTimeSlot(
        date: date,
        startTime: startTime,
        endTime: endTime,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, TimeSlot>> updateTimeSlot({
    required int id,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await remoteDataSource.updateTimeSlot(
        id: id,
        date: date,
        startTime: startTime,
        endTime: endTime,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnAuthorizedException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on UnprocessableContentException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}

