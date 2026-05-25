import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

part 'teacher_detail_state.dart';

class TeacherDetailCubit extends Cubit<TeacherDetailState> {
  final CoursesRepositories _coursesRepository;

  TeacherDetailCubit(this._coursesRepository) : super(TeacherDetailState());

  Future<void> getTeacherDetail(int teacherId, int subjectId) async {
    emit(state.copyWith(status: TeacherDetailRequestState.loading));

    final result = await _coursesRepository.getTeacherDetail(
      teacherId: teacherId,
      subjectId: subjectId,
    );

    await result.fold<Future<void>>(
      (failure) async {
        String msg = "Unknown error occurred";
        if (failure is ServerFailure) msg = failure.message;
        if (failure is AuthFailure) msg = failure.message;
        emit(
          state.copyWith(status: TeacherDetailRequestState.error, message: msg),
        );
      },
      (response) async {
        final teacherDetail = TeacherDetail.fromJson(response['data']);

        final reviewsResult = await _coursesRepository.getTeacherReviews(
          teacherId: teacherId,
        );
        final timeSlotsResult = await _coursesRepository.getTeacherTimeSlots(
          teacherId: teacherId,
        );

        List<TeacherReview> parsedReviews = [];
        reviewsResult.fold(
          (reviewFailure) {
            log("Failed to fetch teacher reviews: $reviewFailure");
          },
          (reviewsList) {
            parsedReviews = reviewsList;
          },
        );

        List<TeacherTimeSlot> parsedTimeSlots = [];
        timeSlotsResult.fold(
          (timeSlotsFailure) {
            log("Failed to fetch teacher time slots: $timeSlotsFailure");
          },
          (timeSlotsList) {
            parsedTimeSlots = timeSlotsList;
          },
        );

        log("---------------- TEACHER GET DATA ----------------");
        log(response.toString());
        log("Parsed reviews count: ${parsedReviews.length}");
        log("Parsed time slots count: ${parsedTimeSlots.length}");
        log("--------------------------------------------------");

        emit(
          state.copyWith(
            status: TeacherDetailRequestState.success,
            teacherDetail: teacherDetail,
            reviews: parsedReviews,
            timeSlots: parsedTimeSlots,
          ),
        );
      },
    );
  }

  Future<bool> bookTeacher({
    required int teacherId,
    required int subjectId,
    required int timeSlotId,
    required int totalHours,
    required String notes,
  }) async {
    emit(state.copyWith(bookingStatus: TeacherDetailRequestState.loading));

    final body = {
      "teacher_id": teacherId,
      "subject_id": subjectId,
      "time_slot_id": timeSlotId,
      "total_hours": totalHours,
      "notes": notes,
    };

    final result = await _coursesRepository.bookTeacher(body: body);
    bool isSuccess = false;

    result.fold(
      (failure) {
        String msg = "Failed to book session";
        if (failure is ServerFailure) msg = failure.message;
        emit(
          state.copyWith(
            bookingStatus: TeacherDetailRequestState.error,
            bookingMessage: msg,
          ),
        );
      },
      (response) {
        emit(
          state.copyWith(
            bookingStatus: TeacherDetailRequestState.success,
            bookingMessage:
                response['message'] ?? "Session booked successfully",
          ),
        );
        isSuccess = true;
      },
    );

    return isSuccess;
  }
}
