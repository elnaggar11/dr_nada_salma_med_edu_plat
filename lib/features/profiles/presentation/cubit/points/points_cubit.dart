import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/points_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/points_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit(this.pointsUseCase) : super(PointsInitial());
  final PointsUseCase pointsUseCase;
  bool? loading = false;
  bool? success = false;
  bool? error = false;
  PointsResponse? pointsResponse;

  Future<void>getPoints()async{
    loading = true;
    success = false;
    error = false;
    emit(PointsLoadingState());
    try{
      final failOrUser = await pointsUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          success = false;
          error = true;
          msgKey.currentState!.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(PointsErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        success = true;
        error = false;
        pointsResponse = response;
        emit(PointsSuccessState(pointsResponse: response));
      });
    }catch(e){
      loading = false;
      success = false;
      error = true;
      msgKey.currentState!.showSnackBar(SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(e.toString()
        ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
    }
  }
}
