import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_degree/academic_degree_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/academic_degree_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'academic_degree_state.dart';

class AcademicDegreeCubit extends Cubit<AcademicDegreeState> {
  AcademicDegreeCubit(this.academicDegreeUseCase)
    : super(AcademicDegreeInitial());
  final AcademicDegreeUseCase academicDegreeUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  String selected = "Enter Academic degree here";
  ExpansibleController? controller = ExpansibleController();
  AcademicDegreeResponse? academicDegreeResponse;
  int? academicDegreeId;

  bool? isChecked;

  Future<void> getAcademicDegrees() async {
    loading = true;
    error = false;
    success = false;

    emit(AcademicDegreeLoadingState());
    try {
      final failOrUser = await academicDegreeUseCase(NoParams());
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
                  style: TextStyles.textStyleNormal12.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(AcademicDegreeErrorState(msg: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          academicDegreeResponse = response;
          emit(AcademicDegreeSuccessState(academicDegreeResponse: response));
        },
      );
    } catch (e) {
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

  Future<void> updateExpand() async {
    controller!.isExpanded ? controller!.collapse() : controller!.expand();
    emit(UpdateSpecialistExpandableState());
  }

  Future<void> setSelectedCheckBox({int? ind, bool? val}) async {
    for (var element in academicDegreeResponse!.data!) {
      element.checked = false;
    }
    academicDegreeResponse!.data![ind!].checked = val;
    selected = "${academicDegreeResponse!.data![ind].name}";
    isChecked = val;
    academicDegreeId = academicDegreeResponse!.data![ind].id;
    emit(UpdateAcademicDegreesCheckBox());
  }
}
