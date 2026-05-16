import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/faqs_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/faqs_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'frequently_asked_state.dart';

class FrequentlyAskedCubit extends Cubit<FrequentlyAskedState> {
  FrequentlyAskedCubit(this.faqsUseCase) : super(FrequentlyAskedInitial());
  final FaqsUseCase faqsUseCase;
  bool? loading  = false;
  bool? error = false;
  bool? success = false;
  FaqsResponse? faqsResponse;
  ExpansibleController? controller;



  Future<void> updateExpand({int? ind,ExpansibleController? controller})async{
    controller!.isExpanded ?
    controller.collapse() :
    controller.expand();
    emit(UpdateFrequentlyAskedExpandableState());
  }

  Future<void>getFaqs()async{
    loading = true;
    error = false;
    success = false;
    emit(FrequentlyAskedLoading());
    try{
      final failOrUser = await faqsUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message
            ,style: TextStyles.textStyleNormal13.copyWith(color: white)
            ,textScaler: TextScaler.linear(1),)));
          emit(FrequentlyAskedErrorState(message: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        faqsResponse = response;

        emit(FrequentlyAskedSuccessState(faqsResponse: response));
      });
    }catch(e){
      msgKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString()
        ,style: TextStyles.textStyleNormal13.copyWith(color: white)
        ,textScaler: TextScaler.linear(1),)));
    }
  }

}
