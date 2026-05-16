import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxRememberWidget extends StatelessWidget {


  CheckboxRememberWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,

          activeColor: greenLight,
          checkboxShape: RoundedRectangleBorder(borderRadius:
          BorderRadius.all(Radius.circular(8.0))),
          title:  Transform.translate(
            offset: const Offset(-10, 0),
            child: RichText(
                textScaler: TextScaler.linear(1.0),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                maxLines: 1,
                text: TextSpan(
                    children: [
                      TextSpan(text: tr("remember_me")
                        ,style: TextStyles.textStyleNormal13
                            .copyWith(fontFamily: lamaSans,color: primary),),

                    ]
                )),
          ),
          value: context.read<LoginCubit>().isChecked,
          onChanged: (bool? newValue) {

              context.read<LoginCubit>().updateChecked(val: newValue);

          },
          contentPadding: EdgeInsets.only(left: context.width/50,right: context.width/50)
      ),
    );

  }
}