import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/hero_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/heroes_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'heroes_state.dart';

class HeroesCubit extends Cubit<HeroesState> {
  HeroesCubit(this.heroesUseCase) : super(HeroesInitial());
  final HeroesUseCase heroesUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  HeroResponse? heroResponse;

  Future<void> getHeroes() async {
    loading = true;
    error = false;
    success = false;
    emit(HeroesLoadingState());
    try {
      final failOrUser = await heroesUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            error = true;
            success = false;
            /* msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));*/
            emit(HeroesErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          error = false;
          success = true;
          heroResponse = response;
          emit(HeroesSuccessState(heroResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      error = true;
      success = false;
    }
  }
}
