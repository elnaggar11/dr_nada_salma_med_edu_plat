import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/usecases/categories_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.categoriesUseCase) : super(CategoriesInitial());
  final CategoriesUseCase categoriesUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  String? type1 = "";
  CategoriesResponse? categoriesResponse;
  int? categoryId;
  String? courseName;

  Future<void>getCategories()async{
    loading = true;
    error = false;
    success = false;
    emit(CategoriesLoadingState());
    try{
      final failOrUser = await categoriesUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message,style:
          TextStyles.textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),)));
          emit(CategoriesErrorState(msg: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        categoriesResponse = response;
        emit(CategoriesSuccessState(categoriesResponse: response));
      });
    }catch(e){
      loading = false;
      error = true;
      success = false;
    }
  }
  Future<void>updateCategoryState({String? type})async{
    type1 = type;
    emit(UpdateCategoryTypeState());
  }
  Future<void>setSelectedCheckBox({int? ind,bool? val})async{
    for (var element in categoriesResponse!.data!) {
      element.checked = false;
    }
    categoriesResponse!.data![ind!].checked = val;
    categoryId = categoriesResponse!.data![ind].id;
    emit(FilterUpdateItemState());
  }
 /* Future<void>setSelectedRatedCheckBox({int? ind,bool? val})async{
    for (var element in ratedItems) {
      element['isChecked'] = false;
    }
    ratedItems[ind!]['isChecked'] = val;
    emit(FilterUpdateItemState());
  }*/
}
