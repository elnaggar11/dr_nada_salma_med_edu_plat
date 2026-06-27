import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/course_reviews_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/repositories/courses_repositories.dart';

part 'course_reviews_state.dart';

class CourseReviewsCubit extends Cubit<CourseReviewsState> {
  final CoursesRepositories _coursesRepository;

  CourseReviewsCubit(this._coursesRepository) : super(CourseReviewsState());

  Future<void> getCourseReviews(int courseId) async {
    emit(state.copyWith(status: CourseReviewsRequestState.loading));

    final result = await _coursesRepository.getCourseReviews(courseId: courseId);

    await result.fold<Future<void>>(
      (failure) async {
        String msg = "Unknown error occurred";
        if (failure is ServerFailure) msg = failure.message;
        if (failure is AuthFailure) msg = failure.message;
        emit(
          state.copyWith(status: CourseReviewsRequestState.error, message: msg),
        );
      },
      (data) async {
        emit(
          state.copyWith(status: CourseReviewsRequestState.loaded, response: data),
        );
      },
    );
  }
}
