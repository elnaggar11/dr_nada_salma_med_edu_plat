import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/courses_details_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'courses_details_state.dart';

class CoursesDetailsCubit extends Cubit<CoursesDetailsState> {
  CoursesDetailsCubit(this.coursesDetailsUseCase)
    : super(CoursesDetailsInitial());
  final CoursesDetailsUseCase coursesDetailsUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  CoursesDetailsResponse? coursesDetailsResponse;
  int? lectureNum = 0;
  double totalTime = 0.0;
  List<Lectures>? lectureList = [];
  String? courseId;

  Future<void> getCoursesDetails({CoursesDetailsParams? params}) async {
    loading = true;
    error = false;
    success = false;
    lectureNum = 0;
    totalTime = 0.0;
    lectureList = [];
    emit(CoursesDetailsLoadingState());
    try {
      final failOrUser = await coursesDetailsUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                ),
              ),
            );
            emit(CoursesDetailsErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          coursesDetailsResponse = response;
          print("reviews${coursesDetailsResponse!.data!.reviews}");
          courseId = response.data!.id.toString();

          if (coursesDetailsResponse!.data!.contents != null) {
            for (var e in coursesDetailsResponse!.data!.contents!) {
              if (e.lectures != null) {
                lectureNum = lectureNum! + e.lectures!.length;
                lectureList!.addAll(e.lectures!);
              }
              if (e.totalTime != null) {
                totalTime = totalTime + (double.tryParse(e.totalTime!) ?? 0.0);
              }
            }
          }

          emit(CoursesDetailsSuccessState(coursesDetailsResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      emit(CoursesDetailsErrorState(message: e.toString()));
    }
  }
}
