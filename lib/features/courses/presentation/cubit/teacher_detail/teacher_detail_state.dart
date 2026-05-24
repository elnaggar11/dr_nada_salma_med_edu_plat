part of 'teacher_detail_cubit.dart';

enum TeacherDetailRequestState { initial, loading, success, error }

class TeacherDetailState {
  final TeacherDetailRequestState status;
  final String? message;
  final TeacherDetail? teacherDetail;

  TeacherDetailState({
    this.status = TeacherDetailRequestState.initial,
    this.message,
    this.teacherDetail,
  });

  TeacherDetailState copyWith({
    TeacherDetailRequestState? status,
    String? message,
    TeacherDetail? teacherDetail,
  }) {
    return TeacherDetailState(
      status: status ?? this.status,
      message: message ?? this.message,
      teacherDetail: teacherDetail ?? this.teacherDetail,
    );
  }
}
