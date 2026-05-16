import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/forgot/forgot_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(this.forgotPasswordUseCase) : super(ForgotPasswordInitial());
  final ForgotPasswordUseCase forgotPasswordUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  Color buttonColor = orange;
  final TextEditingController mailController = TextEditingController();


  Future<void>forgot({ForgotPasswordParams? params})async{
    loading = true;
    error = false;
    success = false;
    buttonColor = loading! ? primary : orangeBold;
    emit(ForgotPasswordLoadingState());
    try{
      final failOrUser = await forgotPasswordUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          buttonColor = loading! ? primary : orangeBold;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(ForgotPasswordErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        buttonColor = loading! ? primary : orangeBold;
        msgKey.currentState!.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(response.message!
          ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));

        VerifyOtpParams params1 = VerifyOtpParams(email: params.email,otp: "",type: "reset");
        navKey.currentContext!.pushReplacementNamed(name: verificationSc,args: params1);
        emit(ForgotPasswordSuccessState(forgotPasswordResponse: response));
      });
    }catch(e){
      loading = false;
      error = false;
      success = true;
      buttonColor = loading! ? primary : orangeBold;
      msgKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString()
        ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
    }
  }
}
