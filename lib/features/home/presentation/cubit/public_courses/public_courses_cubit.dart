import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/public_courses_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'public_courses_state.dart';

class PublicCoursesCubit extends Cubit<PublicCoursesState> {
  final PublicCoursesUseCase publicCoursesUseCase;

  bool loading = false;
  bool error = false;
  bool success = false;
  PublicCoursesResponse? publicCoursesResponse;

  PublicCoursesCubit(this.publicCoursesUseCase)
    : super(PublicCoursesInitialState());

  int currentPage = 1;
  bool isFetching = false;

  /// Fetches public courses with optional params.
  /// Handles pagination, infinite scroll, and errors.
  Future<void> getPublicCourses({
    required String? type,
    required String? name,
    required String? categoryId,
    required String topRated,
    String? courseStatus,
    String? isEnded,
  }) async {
    if (isFetching) return; // prevent multiple simultaneous requests
    isFetching = true;

    final currentState = state;
    final previousCourses = currentState is PublicCoursesLoaded
        ? currentState.courses
        : <Data>[];

    emit(PublicCoursesLoading(previousCourses, isFirstFetch: currentPage == 1));

    try {
      // Default params if none provided
      CoursesParams params = CoursesParams(
        page: currentPage,
        type: type,
        courseName: name,
        categoryId: categoryId,
        topRated: topRated,
        courseStatus: courseStatus,
        isEnded: isEnded,
        limit: 8,
      );

      final failOrResponse = await publicCoursesUseCase(params);

      failOrResponse.fold(
        (failure) {
          if (failure is ServerFailure) {
            emit(PublicCoursesError(failure.message));
          }
        },
        (response) {
          // Append new courses immutably
          final newCourses = List<Data>.from(previousCourses)
            ..addAll(response.data ?? []);

          final hasReachedMax = response.data == null || response.data!.isEmpty;

          emit(
            PublicCoursesLoaded(
              courses: newCourses,
              hasReachedMax: hasReachedMax,
            ),
          );

          if (!hasReachedMax) currentPage++;
        },
      );
    } catch (e) {
      emit(PublicCoursesError(e.toString()));
    } finally {
      isFetching = false;
    }
  }

  Future<void> resetCourses({required CoursesParams params}) async {
    loading = true;
    error = false;
    success = false;
    emit(PublicCoursesLoadingState());
    try {
      final failOrResponse = await publicCoursesUseCase(params);

      failOrResponse.fold(
        (fail) {
          loading = false;
          error = true;
          success = false;
          if (fail is ServerFailure) {
            emit(ResetCoursesError(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          publicCoursesResponse = response;
          emit(ResetCoursesSuccessState(publicCoursesResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
    }
  }
}
