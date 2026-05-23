import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/terms_conditions_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/terms_conditions_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit(this.termsConditionsUseCase) : super(TermsInitial());
  final TermsConditionsUseCase termsConditionsUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  TermsConditionsResponse? termsConditionsResponse;

  Future<void> getTermsConditions() async {
    loading = true;
    error = false;
    success = false;
    emit(TermsLoadingState());
    try {
      final failOrUser = await termsConditionsUseCase(NoParams());

      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
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
            emit(TermsErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          termsConditionsResponse = response;
          emit(TermsSuccessState(termsConditionsResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
      emit(TermsErrorState(message: e.toString()));
    }
  }
}
