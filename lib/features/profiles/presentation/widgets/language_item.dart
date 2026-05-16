import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/lang/language_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageItem extends StatelessWidget {
  final Map<String,dynamic>item;
  final int index;

  LanguageItem({required this.item,required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: context.width/25,right: context.width/25,top: context.width/52
          ,bottom: context.width/52),
      alignment: Alignment.center,
      width: double.infinity,
      decoration: BoxDecoration(
        color: item['isChecked'] == true ? primary : greyLight,
        borderRadius: BorderRadius.all(Radius.circular(40.0)),
        shape: BoxShape.rectangle),
      child: Row(
        children: [
          Expanded(
            child: CheckboxListTile(
              controlAffinity: ListTileControlAffinity.trailing,
              contentPadding: EdgeInsets.only(left: 8,right: 8),
      
              activeColor: orangeBold,
              visualDensity: VisualDensity(horizontal: -4),
              checkboxShape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(8.0))),
              shape: RoundedRectangleBorder(borderRadius:
              BorderRadius.all(Radius.circular(8.0))),
              title: Text(item['name'],
                style: TextStyles.textStyleBold12.copyWith(color: item['isChecked'] == true
                    ? white : primary
                    ,fontFamily: poppins
                    ,fontWeight: FontWeight.w700 ),
                textScaler: TextScaler.linear(1.0),),
              value: item['isChecked'],
              onChanged: (value) {
                context.read<LanguageCubit>().setSelectedCheckBox(ind: index,val: value);
              },),),
        ],
      ),
    );
  }
  
}