import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/resend_otp/resend_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'resend_otp_state.dart';

class ResendOtpCubit extends Cubit<ResendOtpState> {
  ResendOtpCubit(this.resendOtpUseCase) : super(ResendOtpInitial());
  final ResendOtpUseCase resendOtpUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  Future<void> resendOtp({ResendOtpParams? params}) async {
    loading = true;
    error = false;
    success = false;
    emit(ResendOtpLoadingState());
    try {
      final failOrUser = await resendOtpUseCase(params!);
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
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(ResendOtpErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          emit(ResendOtpSuccessState(response: response));
        },
      );
    } catch (e) {
      msgKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
      loading = false;
      error = true;
      success = false;
    }
  }
}
