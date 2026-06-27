part of 'course_reviews_cubit.dart';

enum CourseReviewsRequestState { initial, loading, loaded, error }

class CourseReviewsState {
  final CourseReviewsRequestState status;
  final CourseReviewsResponse? response;
  final String message;

  CourseReviewsState({
    this.status = CourseReviewsRequestState.initial,
    this.response,
    this.message = '',
  });

  CourseReviewsState copyWith({
    CourseReviewsRequestState? status,
    CourseReviewsResponse? response,
    String? message,
  }) {
    return CourseReviewsState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }
}
