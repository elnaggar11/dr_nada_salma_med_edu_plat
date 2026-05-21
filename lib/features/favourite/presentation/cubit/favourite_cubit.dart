import 'dart:math';

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/add_to_favourite_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourite_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/entities/favourtie_response.dart'
    hide Data;
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/usecases/add_to_favourite_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/favourite/domain/usecases/fav_by_user_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/public_courses_response.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favouriteUseCase, this.favByUserUseCase)
    : super(FavouriteInitial());

  final AddToFavouriteUseCase favouriteUseCase;
  final FavByUserUseCase favByUserUseCase;

  FavouriteResponse? favouriteResponse;

  FavouriteParams? favouriteParams;

  List<Data> myFavourites = [];
  bool loading = false;

  bool? favLoading = false;
  bool? favError = false;
  bool? favSuccess = false;

  static FavouriteCubit get(BuildContext context) => BlocProvider.of(context);

  toggleFavAd(String? adId) async {
    emit(FavouriteLoading());

    final failOrSuccess = await favouriteUseCase(
      FavouriteParams(favouriteId: adId),
    );

    failOrSuccess.fold(
      (fail) {
        if (fail is ServerFailure) {
          emit(FavouriteError(message: fail.message));
          fail.message;
          log(fail.message as num);
        }
        loading = false;
      },
      (success) async {
        loading = false;
        msgKey.currentState!.showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40)),
            ),
            content: Text(
              success.message!,
              style: TextStyles.textStyleNormal13.copyWith(color: white),
              textScaler: TextScaler.linear(1),
            ),
          ),
        );
        emit(FavouriteSuccess(response: success));
        if (!success.status!) {
          myFavourites.removeWhere((item) => item.id == adId);
          emit(FavouriteLoaded(adsDatumList: myFavourites));
        }
      },
    );
  }

  doFavourite(bool fav, String adId) async {
    switch (fav == false) {
      case true:
        fav = true;
        toggleFavAd(adId);

        break;
      case false:
        fav = false;
        toggleFavAd(adId);
    }
  }

  Future<void> getFavouritesByUser() async {
    favLoading = true;
    favError = false;
    favSuccess = false;
    emit(FavouriteLoading());
    try {
      final failOrUser = await favByUserUseCase(NoParams());
      failOrUser.fold(
        (fail) {
          if (fail is ServerFailure) {
            favLoading = false;
            favError = true;
            favSuccess = false;
            msgKey.currentState!.showSnackBar(
              SnackBar(
                content: Text(
                  fail.message,
                  style: TextStyles.textStyleNormal13.copyWith(color: white),
                  textScaler: TextScaler.linear(1),
                ),
              ),
            );
            emit(FavouriteError(message: fail.message));
          }
        },
        (success) {
          favLoading = false;
          favError = false;
          favSuccess = true;
          favouriteResponse = success;
          emit(FavouritesByUserSuccess(response: success));
        },
      );
    } catch (e) {
      favLoading = false;
      favError = true;
      favSuccess = false;
    }
  }
}
