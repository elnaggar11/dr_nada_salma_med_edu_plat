import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/check/check_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/check_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  CheckOtpCubit(this.checkOtpUseCase) : super(CheckOtpInitial());
  final CheckOtpUseCase checkOtpUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  Future<void>checkOtp({CheckOtpParams? params})async{
    loading = true;
    error = false;
    success = false;
    emit(CheckOtpLoading());
    try{
      final failOrUser = await checkOtpUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!
              .showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(fail.message,
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),)));
          emit(CheckOtpError(msg: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        msgKey.currentState!
            .showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(response.message!,
              style: TextStyles.textStyleNormal13.copyWith(color: white),
              textScaler: TextScaler.linear(1),)));
        navKey.currentContext!.pushNamed(name: resetPassSc,args: params);
        emit(CheckOtpSuccess(checkOtpResponse: response));
      });
    }catch(e){
      loading = false;
      error = true;
      success = false;
      emit(CheckOtpError(msg: e.toString()));
    }
  }
}
