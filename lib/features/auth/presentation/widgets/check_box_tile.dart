import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/fonts.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckboxListTileWidget extends StatefulWidget {
  final String title;

  const CheckboxListTileWidget({super.key, required this.title});

  @override
  _CheckboxListTileWidgetState createState() => _CheckboxListTileWidgetState();
}

class _CheckboxListTileWidgetState extends State<CheckboxListTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CheckboxListTile(
        controlAffinity: context.locale.languageCode == "ar"
            ? ListTileControlAffinity.trailing
            : ListTileControlAffinity.leading,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeColor: greenLight,
        checkboxShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: RichText(
            textScaler: TextScaler.linear(1.0),
            textAlign: TextAlign.start,
            softWrap: true,
            maxLines: 2,
            textHeightBehavior: TextHeightBehavior(
              applyHeightToLastDescent: true,
              applyHeightToFirstAscent: true,
            ),
            text: TextSpan(
              children: [
                TextSpan(
                  text: tr("by_click"),
                  style: TextStyles.textStyleNormal13.copyWith(
                    fontFamily: lamaSans,
                    color: grey1,
                  ),
                ),

                TextSpan(
                  text: " ${widget.title}",
                  style: TextStyles.textStyleNormal13.copyWith(
                    fontFamily: lamaSans,
                    color: primary,
                  ),
                ),
                TextSpan(
                  text: tr("you_agree"),
                  style: TextStyles.textStyleNormal13.copyWith(
                    fontFamily: lamaSans,
                    color: grey1,
                  ),
                ),
                TextSpan(
                  text: tr("terms_conditions_privacy"),
                  style: TextStyles.textStyleNormal13.copyWith(
                    fontFamily: lamaSans,
                    color: orangeBold,
                  ),
                ),
              ],
            ),
          ),
        ),
        value: context.read<RegisterCubit>().isChecked,
        onChanged: (bool? newValue) {
          context.read<RegisterCubit>().isTermsChecked(newValue: newValue);
        },
        contentPadding: EdgeInsets.only(
          left: context.width / 60,
          right: context.width / 60,
        ),
      ),
    );
  }
}
