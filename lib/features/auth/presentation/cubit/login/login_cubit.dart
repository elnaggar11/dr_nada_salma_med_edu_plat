import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/utils/const.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/login/login_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/login_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginUseCase) : super(LoginInitial());
  bool? isPressed = false;
  Color? buttonColor = orangeBold;
  String selected = "";
  String selected2 = "";
  final LoginUseCase loginUseCase;

  bool? loading = false;
  bool? error = false;
  bool? success = false;

  bool? obscure = true;
  bool? isChecked = false;
  String? fcmToken;

  Future<void> login({LoginParams? params}) async {
    loading = true;
    error = false;
    success = false;
    buttonColor = loading! ? primary : orangeBold;
    emit(LoginLoadingState());
    try {
      final failOrUser = await loginUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            buttonColor = loading! ? primary : orangeBold;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(LoginErrorState(message: fail.message));
          }
        },
        (user) async {
          loading = false;
          error = false;
          success = true;

          if (isChecked == true) {
            await sharedPreferences.setBool("saveUser", true);
          } else {
            await sharedPreferences.setBool("saveUser", false);
          }
          buttonColor = loading! ? primary : orangeBold;
          msgKey.currentState!.showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                user.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );
          navKey.currentContext?.pushReplacementNamed(name: bottomBarSc);
          await sharedPreferences.setBool("saveUser", true);
          await sharedPreferences.setBool("isTeacher", params.isTeacher);
          Const.isTeacher = params.isTeacher;
          if (user.data != null) {
            await sharedPreferences.setInt("user_id", user.data!.id ?? 0);
            await sharedPreferences.setString("user_email", user.data!.email ?? "");
            await sharedPreferences.setString("user_fullName", user.data!.fullName ?? "");
          }

          emit(LoginSuccessState(loginResponse: user));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      buttonColor = loading! ? primary : orangeBold;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal13.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
    }
  }

  Future<void> setVisibility({bool? visibility}) async {
    obscure = !visibility!;
    emit(UpdateLoginVisibility());
  }

  Future<void> updateChecked({bool? val}) async {
    isChecked = val;
    emit(UpdateCheckedState());
  }

  Future<void> getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcm Token :$fcmToken');
  }
}
