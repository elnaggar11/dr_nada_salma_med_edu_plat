import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/success_stories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/usecases/success_stories_use_case.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'success_stories_state.dart';

class SuccessStoriesCubit extends Cubit<SuccessStoriesState> {
  SuccessStoriesCubit(this.successStoriesUseCase)
    : super(SuccessStoriesInitial());
  final SuccessStoriesUseCase successStoriesUseCase;
  bool? loading = false;
  bool? success = false;
  bool? error = false;
  SuccessStoriesResponse? successStoriesResponse;

  Future<void> getSuccessStories() async {
    loading = true;
    success = false;
    error = false;
    emit(SuccessStoriesLoadingState());
    try {
      final failOrUser = await successStoriesUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            loading = false;
            success = false;
            error = true;
            /* msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message,style:
          TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));*/
            emit(SuccessStoriesErrorState(message: fail.message));
          }
        },
        (response) {
          loading = false;
          success = true;
          error = false;
          successStoriesResponse = response;
          emit(SuccessStoriesSuccessState(successStoriesResponse: response));
        },
      );
    } catch (e) {
      loading = false;
      success = false;
      error = true;
    }
  }
}
