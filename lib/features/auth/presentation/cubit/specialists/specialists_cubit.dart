import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/specialists/specialist_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/usecases/specialist_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'specialists_state.dart';

class SpecialistsCubit extends Cubit<SpecialistsState> {
  SpecialistsCubit(this.specialistUseCase) : super(SpecialistsInitial());
  final SpecialistUseCase specialistUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;

  ExpansibleController? controller = ExpansibleController();

  String selected = "Enter your specialty here";
  int? specialistId;
  SpecialistResponse? specialistResponse;

  bool? isChecked;

  Future<void> getSpecialists() async {
    loading = true;
    error = false;
    success = false;
    emit(SpecialistsLoadingState());
    try {
      final failOrUser = await specialistUseCase(NoParams());
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
            emit(SpecialistsErrorState(msg: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          specialistResponse = response;
          emit(SpecialistsSuccessState(specialistResponse: response));
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
    for (var element in specialistResponse!.data!) {
      element.isChecked = false;
    }
    specialistResponse!.data![ind!].isChecked = val;
    selected = "${specialistResponse!.data![ind].name}";
    specialistId = specialistResponse!.data![ind].id;
    isChecked = val;
    emit(UpdateSpecialistCheckBox());
  }
}
