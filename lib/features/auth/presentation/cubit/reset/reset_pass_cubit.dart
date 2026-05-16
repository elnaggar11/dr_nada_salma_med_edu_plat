import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/reset_password/reset_password_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/successfull_dialog.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'reset_pass_state.dart';

class ResetPassCubit extends Cubit<ResetPassState> {
  ResetPassCubit(this.resetPasswordUseCase) : super(ResetPassInitial());
  final ResetPasswordUseCase resetPasswordUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  bool? obscure = true;
  bool? obscure2 = true;

  Color buttonColor = orange;

  Future<void>resetPassword({ResetPasswordParams? params})async{
    loading = true;
    error = false;
    success = false;
    buttonColor = loading! ? primary : orange;
    emit(ResetPasswordLoadingState());
    try{
      final failOrUser = await resetPasswordUseCase(params!);
      failOrUser.fold((fail){
        if(fail is ServerFailure){

          loading = false;
          error = true;
          success = false;
          buttonColor = loading! ? primary : orange;

          msgKey.currentState!.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(fail.message!,style:
          TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(ResetPasswordErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        buttonColor = loading! ? primary : orange;

        showDialog(
          context: navKey.currentContext!,
          builder: (BuildContext context) {
            return SuccessfullDialogWidget(msg: response.message!,);
          },);

      //  navKey.currentContext!.pushNamed(name:bottomBarSc);

        emit(ResetPasswordSuccessState(resetPasswordResponse: response));
      });

    }catch(e){
      loading = false;
      error = true;
      success = false;
      buttonColor = loading! ? primary : orange;
      msgKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString(),style:
      TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
      emit(ResetPasswordErrorState(message: e.toString()));
    }
  }
  Future<void>setVisibility({bool? visibility,String? type})async{
    if(type == "password"){
      obscure = !visibility!;
      emit(ResetUpdateVisibilityState());
    }else if(type == "confirmPassword"){
      obscure2 = !visibility!;
      emit(UpdateConfirmationPasswordVisibilityState());
    }
  }
}
