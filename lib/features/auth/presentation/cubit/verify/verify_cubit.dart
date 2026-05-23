import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit(this.verifyOtpUseCase) : super(VerifyInitial());
  final TextEditingController verificationCodeController =
      TextEditingController();

  bool? isPressed = false;
  Color? buttonColor = orange;
  final VerifyOtpUseCase verifyOtpUseCase;
  VerifyOtpResponse? verifyOtpResponse;

  bool? loading = false;
  bool? error = false;
  bool? success = false;

  Timer? timer;
  int start = 120;
  String? fcmToken;

  Future<void> verifyOtp({VerifyOtpParams? params}) async {
    loading = true;
    success = false;
    error = false;
    buttonColor = loading! ? primary : orange;
    emit(VerifyOtpLoadingState());
    try {
      final failOrUser = await verifyOtpUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            success = false;
            error = true;
            buttonColor = loading! ? primary : orange;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(VerifyErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          success = true;
          error = false;

          buttonColor = loading! ? primary : orange;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          verifyOtpResponse = response;

          navKey.currentContext!.pushNamed(name: bottomBarSc, args: params);

          emit(VerifyOtpSuccessState(verifyOtpResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      success = false;
      error = true;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
      emit(VerifyErrorState(message: e.toString()));
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        timer.cancel();
        emit(UpdateTimerState());
      } else {
        start--;
        emit(UpdateTimerState());
      }
    });
  }

  String get timerText {
    int minutes = start ~/ 60;
    int seconds = start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm Token :$fcmToken');
  }
}
