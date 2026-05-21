import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/register/register_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/register_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerUseCase) : super(RegisterInitial());
  bool? isPressed = false;
  Color? buttonColor = primary;
  final RegisterUseCase registerUseCase;

  bool? loading = false;
  bool? error = false;
  bool? success = false;

  bool? obscure = true;

  bool? obscure2 = true;

  bool? isChecked = false;

  Future<void> setButtonAnimation() async {
    isPressed = !isPressed!;
    buttonColor = isPressed! ? orangeBold : primary;
    // Change color based on state

    emit(UpdateRegisterState());
  }

  Future<void> register({RegisterParams? params}) async {
    loading = true;
    error = false;
    success = false;

    buttonColor = loading! ? orangeBold : primary;

    emit(RegisterLoadingState());
    try {
      final failOrUser = await registerUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            buttonColor = loading! ? orangeBold : primary;

            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal12.copyWith(color: white),
                ),
              ),
            );
            emit(RegisterErrorState(msg: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          buttonColor = loading! ? orangeBold : primary;

          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal12.copyWith(color: white),
              ),
            ),
          );

          navKey.currentContext!.pushReplacementNamed(
            name: secondRegisterSc,
            args: params.email,
          );
          emit(RegisterSuccessState(response: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      buttonColor = loading! ? orangeBold : primary;
      emit(RegisterErrorState(msg: e.toString()));
    }
  }

  Future<void> setVisibility({bool? visibility, String? type}) async {
    if (type == "password") {
      obscure = !visibility!;
      emit(UpdateVisibilityState());
    } else if (type == "confirmPassword") {
      obscure2 = !visibility!;
      emit(UpdateConfirmationPasswordVisibilityState());
    }
  }

  Future<void> isTermsChecked({bool? newValue}) async {
    isChecked = newValue!;

    emit(TermsCheckedState());
  }
}
