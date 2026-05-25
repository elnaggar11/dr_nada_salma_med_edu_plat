import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/courses_status_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/usecases/courses_status_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_status_state.dart';

class CoursesStatusCubit extends Cubit<CoursesStatusState> {
  CoursesStatusCubit(this.coursesStatusUseCase) : super(CoursesStatusInitial());
  final CoursesStatusUseCase coursesStatusUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  CoursesStatusResponse? coursesStatusResponse;
  String? courseStatus = "in_progress";

  TabController? tabController;

  Future<void> getCoursesStatus({CoursesStatusParams? params}) async {
    loading = true;
    error = false;
    success = false;
    emit(CoursesStatusLoadingState());
    try {
      final failOrUser = await coursesStatusUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            final message = _safeErrorMessage(fail.message);
            loading = false;
            error = true;
            success = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(CoursesStatusErrorState(message: message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          coursesStatusResponse = response;
          emit(CoursesStatusSuccessState(coursesStatusResponse: response));
        },
      );
    } catch (e) {
      final message = _safeErrorMessage(e.toString());
      loading = false;
      error = true;
      success = false;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            message,
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
      emit(CoursesStatusErrorState(message: message));
    }
  }

  Future<void> updateTabState({String? type}) async {
    courseStatus = type;
    emit(UpdateCoursesTabState());
  }

  String _safeErrorMessage(String? message) {
    final value = message?.trim();
    if (value == null || value.isEmpty || value.toLowerCase() == "null") {
      return "Something went wrong";
    }
    return value;
  }
}
