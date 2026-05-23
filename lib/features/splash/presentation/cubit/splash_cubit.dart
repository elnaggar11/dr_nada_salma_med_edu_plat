import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart';
import 'package:dr_nada_salma_med_edu_plat/injection_container/injection_container.dart'
    as di;
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());
  bool? isPressed = false;
  Color? buttonColor = orangeBold;

  Future<void> setSplash() async {
    if (navKey.currentContext!.locale.languageCode == "en") {
      di.helper.updateLocalHeader("en");
    } else {
      di.helper.updateLocalHeader("ar");
    }
    bool? user = sharedPreferences.getBool("saveUser");
    Future.delayed(
      Duration(milliseconds: 9500),
      () => user == true
          ? navKey.currentContext!.pushReplacementNamed(name: bottomBarSc)
          : navKey.currentContext!.pushReplacementNamed(name: secondSplash),
    );
  }

  Future<void> setButtonAnimation() async {
    isPressed = !isPressed!;
    buttonColor = isPressed!
        ? primary
        : orangeBold; // Change color based on state

    emit(UpdateButtonAnimation());
  }
}
