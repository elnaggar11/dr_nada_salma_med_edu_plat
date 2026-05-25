part of 'teacher_detail_cubit.dart';

enum TeacherDetailRequestState { initial, loading, success, error }

class TeacherDetailState {
  final TeacherDetailRequestState status;
  final String? message;
  final TeacherDetail? teacherDetail;
  final List<TeacherReview> reviews;
  final List<TeacherTimeSlot> timeSlots;
  final TeacherDetailRequestState bookingStatus;
  final String? bookingMessage;

  TeacherDetailState({
    this.status = TeacherDetailRequestState.initial,
    this.message,
    this.teacherDetail,
    this.reviews = const [],
    this.timeSlots = const [],
    this.bookingStatus = TeacherDetailRequestState.initial,
    this.bookingMessage,
  });

  TeacherDetailState copyWith({
    TeacherDetailRequestState? status,
    String? message,
    TeacherDetail? teacherDetail,
    List<TeacherReview>? reviews,
    List<TeacherTimeSlot>? timeSlots,
    TeacherDetailRequestState? bookingStatus,
    String? bookingMessage,
  }) {
    return TeacherDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      teacherDetail: teacherDetail ?? this.teacherDetail,
      reviews: reviews ?? this.reviews,
      timeSlots: timeSlots ?? this.timeSlots,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingMessage: bookingMessage ?? this.bookingMessage,
    );
  }
}
