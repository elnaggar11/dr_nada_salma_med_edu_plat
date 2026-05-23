import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/academic_info_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'academic_info_state.dart';

class AcademicInfoCubit extends Cubit<AcademicInfoState> {
  AcademicInfoCubit(this.academicInfoUseCase) : super(AcademicInfoInitial());
  final AcademicInfoUseCase academicInfoUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  Color? buttonColor = primary;

  Future<void> setAcademicInfo({AcademicInfoParams? params}) async {
    loading = true;
    error = false;
    success = false;

    buttonColor = loading! ? orangeBold : primary;
    emit(AcademicInfoLoadingState());
    try {
      final failOrUser = await academicInfoUseCase(params!);
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;

            buttonColor = loading! ? orangeBold : primary;

            msgKey.currentState!.showSnackBar(
              SnackBar(
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal12.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );

            emit(AcademicInfoErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;

          buttonColor = loading! ? orangeBold : primary;

          msgKey.currentState!.showSnackBar(
            SnackBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              behavior: SnackBarBehavior.floating,
              content: Text(
                response.message!,
                style: TextStyles.textStyleNormal13.copyWith(color: white),
                textScaler: TextScaler.linear(1),
              ),
            ),
          );

          navKey.currentContext!.pushNamed(name: termsSc, args: params);

          emit(AcademicInfoSuccessState(academicInfoResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      buttonColor = loading! ? orangeBold : primary;
      msgKey.currentState!.showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
            style: TextStyles.textStyleNormal12.copyWith(color: white),
            textScaler: TextScaler.linear(1),
          ),
        ),
      );
    }
  }
}
