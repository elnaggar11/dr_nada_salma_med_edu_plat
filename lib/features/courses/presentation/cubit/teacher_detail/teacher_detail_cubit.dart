import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/teacher/teacher_detail_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

part 'teacher_detail_state.dart';

class TeacherDetailCubit extends Cubit<TeacherDetailState> {
  final CoursesRepositories _coursesRepository;

  TeacherDetailCubit(this._coursesRepository) : super(TeacherDetailState());

  Future<void> getTeacherDetail(String slug) async {
    emit(state.copyWith(status: TeacherDetailRequestState.loading));

    final result = await _coursesRepository.getTeacherDetail(slug: slug);

    result.fold(
      (failure) {
        String msg = "Unknown error occurred";
        if (failure is ServerFailure) msg = failure.message;
        if (failure is AuthFailure) msg = failure.message;
        emit(
          state.copyWith(status: TeacherDetailRequestState.error, message: msg),
        );
      },
      (response) => emit(
        state.copyWith(
          status: TeacherDetailRequestState.success,
          teacherDetail: TeacherDetail.fromJson(response),
        ),
      ),
    );
  }
}
