import 'package:dr_nada_salma_med_edu_plat/core/errors/exceptions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/api_base_helper.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'package:dr_nada_salma_med_edu_plat/features/appointments/domain/entities/time_slot_response.dart';

const String getTimeSlotsApi = "/teacher/time-slots";
const String deleteTimeSlotApi = "/teacher/time-slots/";

abstract class AppointmentsRemoteDataSource {
  Future<TimeSlotResponse> getTimeSlots();
  Future<Map<String, dynamic>> deleteTimeSlot(int id);
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
}

class AppointmentsRemoteDataSourceImpl implements AppointmentsRemoteDataSource {
  final ApiBaseHelper helper;

  AppointmentsRemoteDataSourceImpl(this.helper);

  @override
  Future<TimeSlotResponse> getTimeSlots() async {
    try {
      if (Const.isTeacher) {
        final response = await helper.get(url: getTimeSlotsApi);
        return TimeSlotResponse.fromJson(response);
      } else {
        final response = await helper.get(url: "/tutoring/bookings");
        final List<TimeSlot> slots = [];
        if (response['data'] != null && response['data'] is List) {
          for (var booking in response['data']) {
            final session = booking['session'];
            if (session != null) {
              slots.add(TimeSlot(
                id: booking['id'] ?? (session['time_slot_id'] ?? 0),
                teacherId: session['time_slot_id'],
                date: session['date'] != null ? DateTime.tryParse(session['date'].toString()) : null,
                startTime: session['start_time'],
                endTime: session['end_time'],
                isBooked: true,
                studentName: booking['student'],
                teacherName: booking['teacher'],
                subjectName: booking['subject'],
              ));
            }
          }
        }
        return TimeSlotResponse(
          status: response['status'] is bool ? response['status'] : true,
          message: response['message'],
          data: slots,
        );
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
  Future<Map<String, dynamic>> deleteTimeSlot(int id) async {
    try {
      final response = await helper.delete(url: "$deleteTimeSlotApi$id");
      return Map<String, dynamic>.from(response);
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
      final response = await helper.postJson(
        url: getTimeSlotsApi,
        body: {"date": date, "start_time": startTime, "end_time": endTime},
      );
      return TimeSlot.fromJson(response['data']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
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
      final response = await helper.putJson(
        url: "$getTimeSlotsApi/$id",
        body: {"date": date, "start_time": startTime, "end_time": endTime},
      );
      return TimeSlot.fromJson(response['data']);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    } on UnAuthorizedException catch (e) {
      throw UnAuthorizedException(message: e.message);
    } on UnprocessableContentException catch (e) {
      throw UnprocessableContentException(message: e.message);
    }
  }
}
