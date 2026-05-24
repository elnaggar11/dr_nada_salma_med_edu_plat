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

    result.fold(
      (failure) {
        String msg = "Unknown error occurred";
        if (failure is ServerFailure) msg = failure.message;
        if (failure is AuthFailure) msg = failure.message;
        emit(
          state.copyWith(status: TeacherDetailRequestState.error, message: msg),
        );
      },
      (response) {
        // Log the complete raw data/JSON response to the console
        log("---------------- TEACHER GET DATA ----------------");
        log(response.toString());
        log("--------------------------------------------------");
        emit(
          state.copyWith(
            status: TeacherDetailRequestState.success,
            teacherDetail: TeacherDetail.fromJson(response['data']),
          ),
        );
      },
    );
  }
}
