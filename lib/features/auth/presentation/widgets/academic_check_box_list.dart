import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/academic_degree/academic_degree_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcademicCheckboxListScreen extends StatelessWidget {
  const AcademicCheckboxListScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount:  context.read<AcademicDegreeCubit>().academicDegreeResponse!.data!.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return CheckboxListTile(
            contentPadding: EdgeInsets.only(left: 16,right: 16),
            dense: true,
            activeColor: primary,
            checkboxShape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(8.0))),
            shape: RoundedRectangleBorder(borderRadius:
            BorderRadius.all(Radius.circular(8.0))),
            title: Text(context.read<AcademicDegreeCubit>().academicDegreeResponse!.data![index].name!
              ,style: TextStyles
                .textStyleNormal12.copyWith(color: primary,fontFamily: poppins
                ,fontWeight: FontWeight.w500 ),
              textScaler: TextScaler.linear(1.0),),
            value: context.read<AcademicDegreeCubit>().academicDegreeResponse!.data![index].checked ?? false,
            onChanged: (value) {
              context.read<AcademicDegreeCubit>().setSelectedCheckBox(ind: index,val: value);
            },

          );
        },
      ),
    );
  }
}