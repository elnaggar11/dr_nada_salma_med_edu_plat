import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/private_lessons_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'private_lessons_state.dart';

class PrivateLessonsCubit extends Cubit<PrivateLessonsState> {
  PrivateLessonsCubit(this.privateLessonsUseCase) : super(PrivateLessonsInitial());
  final PrivateLessonsUseCase privateLessonsUseCase;
  bool? loading = false;
  bool? success = false;
  bool? error  = false;
  PublicCoursesResponse? publicCoursesResponse;

  Future<void>getPrivateLessons({CoursesParams? params})async{
    loading = true;
    success = false;
    error = false;
    emit(PrivateLessonsLoadingState());
    try{
      final failOrUser = await privateLessonsUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          success = false;
          error = true;
      /*    msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message,style:
          TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));*/
          emit(PrivateLessonsErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        success = true;
        error = false;
        publicCoursesResponse = response;
        emit(PrivateLessonsSuccessState(publicCoursesResponse: response));
      });

    }catch(e){
      loading = false;
      success = false;
      error = true;
    }
  }
  Future<List<Data>> getPaginatedCourses({
    required int page,
    required int limit,
    required CoursesParams params,
  }) async {
    try {
      // Copy current params and add page/limit
      final updatedParams = params.copyWith(page: page, limit: limit);

      final result = await privateLessonsUseCase(updatedParams);

      return result.fold((fail) {
        if(fail is ServerFailure){
          emit(PrivateLessonsErrorState(message: fail.message));
        }

        return [];
      }, (response) {
        publicCoursesResponse = response;
        emit(PrivateLessonsSuccessState(publicCoursesResponse: response));
        return response.data ?? [];
      });
    } catch (e) {
      emit(PrivateLessonsErrorState(message: e.toString()));
      return [];
    }
  }

}
