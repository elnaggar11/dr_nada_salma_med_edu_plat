import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/model/time_slot.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';

abstract class AppointmentsRemoteDataSource {
  Future<List<TimeSlot>> fetchTimeSlots();
  Future<TimeSlot> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  });
  Future<TimeSlot> updateTimeSlot({
    required int id,
    required String date,
    required String startTime,
    required String endTime,
  });
  Future<void> deleteTimeSlot(int id);
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  final ApiBaseHelper helper;

  AppointmentsRemoteDataSourceImpl(this.helper);

  @override
  Future<List<TimeSlot>> fetchTimeSlots() async {
    try {
      final response = await helper.get(url: "/teacher/time-slots");
      if (response != null && response['status'] == true) {
        final List<dynamic> data = response['data'] ?? [];
        return data.map((e) => TimeSlot.fromJson(e)).toList();
      } else {
        throw ServerException(message: response?['message'] ?? 'Failed to load time slots');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }

  @override
  Future<TimeSlot> addTimeSlot({
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await helper.dio.post(
        "/teacher/time-slots",
        data: {
          "date": date,
          "start_time": startTime,
          "end_time": endTime,
        },
      );
      if (response.statusCode == 200 && response.data != null && response.data['status'] == true) {
        return TimeSlot.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Failed to add time slot');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<TimeSlot> updateTimeSlot({
    required int id,
    required String date,
    required String startTime,
    required String endTime,
  }) async {
    try {
      final response = await helper.dio.put(
        "/teacher/time-slots/$id",
        data: {
          "date": date,
          "start_time": startTime,
          "end_time": endTime,
        },
      );
      if (response.statusCode == 200 && response.data != null && response.data['status'] == true) {
        return TimeSlot.fromJson(response.data['data']);
      } else {
        throw ServerException(message: response.data?['message'] ?? 'Failed to update time slot');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> deleteTimeSlot(int id) async {
    try {
      final response = await helper.delete(url: "/teacher/time-slots/$id");
      if (response == null || response['status'] != true) {
        throw ServerException(message: response?['message'] ?? 'Failed to delete time slot');
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
