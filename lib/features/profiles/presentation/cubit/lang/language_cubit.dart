import 'package:bloc/bloc.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());

  String? lang = navKey.currentContext!.locale.languageCode;

  late List<Map<String, dynamic>> items = [
    {'name': 'English', 'isChecked': lang! == "en" ?  true : false},
    {'name': 'Arabic', 'isChecked': lang! == "ar" ?  true : false},

  ];

  Future<void>setSelectedCheckBox({int? ind,bool? val})async{
    for (var element in items) {
      element['isChecked'] = false;
    }
    items[ind!]['isChecked'] = val;
    if(items[ind]['name'] == 'English'){
      lang = "en";

    }else {
      lang = "ar";

    }

    emit(UpdateLanguageState());
  }
}
