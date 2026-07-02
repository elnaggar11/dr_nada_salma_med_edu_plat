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
        final timeSlotsResponse = await helper.get(url: getTimeSlotsApi);
        final timeSlotsList = TimeSlotResponse.fromJson(timeSlotsResponse).data ?? [];

        try {
          final bookingsResponse = await helper.get(url: "/teacher/tutoring/bookings");
          final bookingsList = TimeSlotResponse.fromJson(bookingsResponse).data ?? [];
          
          for (var slot in timeSlotsList) {
            if (slot.isBooked == true) {
               final matchingBookingList = bookingsList.where(
                 (b) => b.id == slot.id || (b.date == slot.date && b.startTime == slot.startTime)
               ).toList();
               
               if (matchingBookingList.isNotEmpty) {
                 final matchingBooking = matchingBookingList.first;
                 if (matchingBooking.studentName != null) {
                    slot.studentName = matchingBooking.studentName;
                 }
                 if (matchingBooking.booking != null) {
                    slot.booking = matchingBooking.booking;
                 }
               }
            }
          }
        } catch (e) {
          // Fallback to just time slots if bookings endpoint fails
        }

        return TimeSlotResponse(status: true, message: "Success", data: timeSlotsList);
      } else {
        final response = await helper.get(url: "/tutoring/bookings");
        return TimeSlotResponse.fromJson(response);
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
