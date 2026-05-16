import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/verify/verify_otp_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/check_box_tile.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsConditionsScreen extends StatelessWidget{
  final AcademicInfoParams params;

  TermsConditionsScreen({required this.params});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: white,
     appBar: customAppBar(
         appBarInd: -1,
         index: -1,
         title: tr("terms_pledge"),status: false,context: context, widget: SizedBox()),

     body: Column(
       mainAxisAlignment: MainAxisAlignment.start,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         SizedBox(height: context.height/50,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("commitment_seriousness"),style: TextStyles.textStyleBold18
               .copyWith(color: orangeBold),textScaler: TextScaler.linear(1)),),
         SizedBox(height: context.height/50,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("pledge_follow_medical")
             ,style: TextStyles.textStyleNormal12
               .copyWith(color: black),textScaler: TextScaler.linear(1)),),
         SizedBox(height: context.height/20,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("respect_ownership"),style: TextStyles.textStyleBold18
               .copyWith(color: orangeBold),textScaler: TextScaler.linear(1)),),
         SizedBox(height: context.height/50,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("pledge_not_to_copy")
             ,style: TextStyles.textStyleNormal12
                 .copyWith(color: black),textScaler: TextScaler.linear(1)),),
         SizedBox(height: context.height/20,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("information_confidentiality"),style: TextStyles.textStyleBold18
               .copyWith(color: orangeBold),textScaler: TextScaler.linear(1)),),
         SizedBox(height: context.height/50,),
         Container(
           padding: EdgeInsets.only(left: context.width/30,right: context.width/30),
           child: Text(tr("maintain_confidentiality")
             ,style: TextStyles.textStyleNormal12
                 .copyWith(color: black),textScaler: TextScaler.linear(1),),),
         SizedBox(height: context.height/50,),
         BlocBuilder<RegisterCubit, RegisterState>(
           builder: (context, state) {
             return CheckboxListTileWidget(title: tr("agree_commitment"),);},),
         Spacer(),
         BlocBuilder<RegisterCubit,RegisterState>(
           builder: (context, state) {
             return FadeColorButton(
               btnTitle: tr("agree_commitment")
               ,buttonColor: context.read<RegisterCubit>().buttonColor
               ,onButtonPressed: (){
                 if(context.read<RegisterCubit>().isChecked == false){
                   msgKey.currentState!.showSnackBar
                     (SnackBar(content:
                   Text(tr("agree_terms"),style: TextStyles
                       .textStyleNormal13.copyWith(color: white),textScaler: TextScaler.linear(1),),));
                 }else {
                   VerifyOtpParams params1 = VerifyOtpParams(email: params.email,type: "register",);
                   Future.delayed(Duration(milliseconds: 300),()=> navKey
                       .currentContext!.pushNamed(name: verificationSc,args: params1));
                   context.read<RegisterCubit>().setButtonAnimation();
                 }

             },
               isPressed:
               context.read<RegisterCubit>().isPressed!,
             );
           },),
         SizedBox(height: context.height/30,)

       ],
     ),
   );
  }

}