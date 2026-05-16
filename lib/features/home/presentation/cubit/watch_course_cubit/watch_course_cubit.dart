import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/watch_course_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/watch_course_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'watch_course_state.dart';

class WatchCourseCubit extends Cubit<WatchCourseState> {
  WatchCourseCubit(this.watchCourseUseCase) : super(WatchCourseInitial());
  final WatchCourseUseCase watchCourseUseCase;
  bool loading = false;
  bool error = false;
  bool success = false;

  Future<void>watchCourse({WatchCourseParams? params})async{
    loading = true;
    error = false;
    success = false;
    emit(WatchCourseLoading());
    try{
      final failOrUser = await watchCourseUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
       /*   msgKey.currentState!.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));*/
          emit(WatchCourseError(message: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
     /*   msgKey.currentState!.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(response.message!
              ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));*/
        emit(WatchCourseSuccess(watchCourseResponse: response));
      });
    }catch(e){
      loading = false;
      error = true;
      success = false;
      emit(WatchCourseError(message: e.toString()));
    }
  }

}
