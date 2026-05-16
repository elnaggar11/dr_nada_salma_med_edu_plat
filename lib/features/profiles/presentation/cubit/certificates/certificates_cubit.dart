import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/errors/failure.dart';
import 'package:dr_nada_salma_med_edu_plat/core/usecase/usecase.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/entities/certificate_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/domain/usecases/certificate_use_case.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:flutter/material.dart';

part 'certificates_state.dart';

class CertificatesCubit extends Cubit<CertificatesState> {
  CertificatesCubit(this.certificateUseCase) : super(CertificatesInitial());
  final CertificateUseCase certificateUseCase;
  bool? loading = false;
  bool? error = false;
  bool? success = false;
  CertificateResponse? certificateResponse;

  Future<void>getCertificates()async{
    loading = true;
    error = false;
    success = false;
    emit(CertificatesLoadingState());
    try{
      final failOrUser = await certificateUseCase(NoParams());
      failOrUser.fold((fail){
        if(fail is ServerFailure){
          loading = false;
          error = true;
          success = false;
          msgKey.currentState!.showSnackBar(SnackBar(content: Text(fail.message,
            style: TextStyles.textStyleNormal13.copyWith(color: white)
            ,textScaler: TextScaler.linear(1),)));
          emit(CertificatesErrorState(msg: fail.message));
        }
      }, (response){
        loading = false;
        error = false;
        success = true;
        certificateResponse = response;
        emit(CertificatesSuccessState(certificateResponse: response));
      });
    }catch(e){
      msgKey.currentState!.showSnackBar(SnackBar(content: Text(e.toString(),
        style: TextStyles.textStyleNormal13.copyWith(color: white)
        ,textScaler: TextScaler.linear(1),)));
      loading = false;
      error = true;
      success = false;

    }
  }
}
