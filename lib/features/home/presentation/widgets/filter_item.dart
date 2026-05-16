import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/domain/entities/categories_response.dart';
import 'package:dr_nada_salma_med_edu_plat/features/courses/presentation/cubit/categories/categories_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/presentation/cubit/filter/filter_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterItem extends StatelessWidget {

  final Data data;
  final int index;
  String? type;


   FilterItem({super.key, required this.data, required this.index,this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.only(left: 8,right: 8),
            activeColor: orangeBold,
            visualDensity: VisualDensity(horizontal: -4),
            checkboxShape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(8.0))),
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(8.0))),
            title: Text(data.name,
              style: TextStyles.textStyleNormal12.copyWith(color: primary,fontFamily: poppins
                ,fontWeight: FontWeight.w500 ),
              textScaler: TextScaler.linear(1.0),),
            value: data.checked ?? false,
            onChanged: (value) {
             /* type == "rate" ?
              context.read<FilterCubit>().setSelectedRatedCheckBox(ind: index,val: value) :*/
              context.read<CategoriesCubit>().setSelectedCheckBox(ind: index,val: value);
            },),),
        Text("${data.countCourses}",style: TextStyles.textStyleNormal12
            .copyWith(fontWeight: FontWeight.w600
            ,color: orangeBold),textScaler: TextScaler.linear(1),),
        SizedBox(width: context.width/20,)
      ],
    );
  }

}