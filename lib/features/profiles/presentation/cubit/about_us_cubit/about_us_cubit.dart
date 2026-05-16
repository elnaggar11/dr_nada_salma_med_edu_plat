import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/about_us_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/about_us_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'about_us_state.dart';

class AboutUsCubit extends Cubit<AboutUsState> {
  AboutUsCubit(this.aboutUsUseCase) : super(AboutUsInitial());
  final AboutUsUseCase aboutUsUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  AboutUsResponse? aboutUsResponse;

  Future<void>getAboutUs()async{
    loading = true;
    error = false;
    success = false;
    emit(AboutUsLoadingState());
    try{
      final failOrUser = await aboutUsUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(AboutUsErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        error = true;
        success = true;
        aboutUsResponse = response;
        emit(AboutUsSuccessState(aboutUsResponse: response));
      });
    }catch(e){
      msgKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString()
        ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
      loading = false;
      error = true;
      success = false;
    }
  }

}
