import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/terms_cubit/terms_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TermsAndConditionsScreen extends StatefulWidget{
  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsScreenState();

}

class _TermsAndConditionsScreenState extends State<TermsAndConditionsScreen> {

  @override
  void initState() {
    context.read<TermsCubit>().getTermsConditions();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
          widget: SizedBox(),title: tr("terms_conditions")
          ,status: false,context: context,appBarInd: 0),
      body: BlocBuilder<TermsCubit, TermsState>(
  builder: (context, state) {
    return context.read<TermsCubit>().loading == true ?
        Center(
          child: SpinKitPulse(color:primary,size: 50,),
        ):

      Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(left: context.width/20,right: context.width/20,top: context.height/50),
        alignment: Alignment.topCenter,
        child: Text(context.read<TermsCubit>().termsConditionsResponse!.data!.description!
          ,style: TextStyles.textStyleNormal15
            .copyWith(color: primary),textScaler: TextScaler.linear(1),),
      );
  },
),
    );
  }
}