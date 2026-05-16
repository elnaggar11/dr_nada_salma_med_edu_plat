import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_text_field.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/domain/entities/academic_info/academic_info_params.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/academic_degree/academic_degree_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/academic_info/academic_info_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/register/register_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/cubit/specialists/specialists_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/academic_check_box_list.dart';
import 'package:dr_nada_salma_med_edu_plat/features/auth/presentation/widgets/specialist_check_box_list.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/custom_app_bar.dart';

class SecondRegisterScreen extends StatefulWidget{
  final String email;

  SecondRegisterScreen({required this.email});

  @override
  State<SecondRegisterScreen> createState() => _SecondLoginScreenState();

}

class _SecondLoginScreenState extends State<SecondRegisterScreen> {
  final ExpansibleController controller = ExpansibleController();

  @override
  void initState() {
    context.read<SpecialistsCubit>().getSpecialists();
    context.read<AcademicDegreeCubit>().getAcademicDegrees();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppBar(
          appBarInd: -1,
          widget: SizedBox(), title: '', status: false, context: context,index: -1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: white,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: context.height/10,),
              Container(
                padding: EdgeInsets.all(23),
                decoration: BoxDecoration(
                  color: orangeBold,
                  shape: BoxShape.circle,),
                child: customSvg(name: user,color: white),),
              SizedBox(height: context.height/40,),
              Text(tr("academic_medical"),style: TextStyles.textStyleBold18
                  .copyWith(fontWeight: FontWeight.w800),),
              SizedBox(height: context.height/120,),
              Text(tr("information"),style: TextStyles.textStyleBold18
                  .copyWith(fontWeight: FontWeight.w800),),
              SizedBox(height: context.height/50,),
              Container(
                margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                child: Text(tr("help_us_recommend"),
                  style: TextStyles.textStyleNormal12.copyWith(color: greey),
                  textAlign: TextAlign.center,textScaler: TextScaler.linear(1),),
              ),
              SizedBox(height: context.height/20,),
              BlocBuilder<SpecialistsCubit,SpecialistsState>(
                builder: (context, state) {
                  return ExpansionTile(
                backgroundColor: white,
                  controller: context.read<SpecialistsCubit>().controller,
                  showTrailingIcon: false,
                  maintainState: true,
                  shape: OutlineInputBorder(borderSide: BorderSide(color: white)),
                  expandedAlignment: Alignment.bottomCenter,
                  title: CustomTextField(controller: TextEditingController
                    (text: context.read<SpecialistsCubit>().selected),
                      isRegistered: false,
                      obscure: false,
                    labelTxt: tr("speciality"),
                    suffixIcon:  InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: (){
                        context.read<SpecialistsCubit>().updateExpand();
                     },
                      child: Container(
                        width: 30,
                        alignment: Alignment.center,
                        child: customSvg(name:  context.read<SpecialistsCubit>().controller!.isExpanded ? expand : collapse),
                      ),),),
                  children: <Widget>[
                   context.read<SpecialistsCubit>().error == true ?
                   SizedBox() :
                   Container(
                      margin: EdgeInsets.only(left: context.width/13,right: context.width/13),
                      width: context.width,
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        border: Border.all(color: black.withOpacity(.1)),
                        borderRadius: BorderRadius.all(Radius.circular(38)),
                      ),// Optional: Add some margin

                        child: context.read<SpecialistsCubit>().specialistResponse == null ?
                        SizedBox() :
                        SpecialtyCheckboxListScreen()


                    ),
                  ],
                );
  },
),
          
                SizedBox(height: context.height/30,),

              BlocBuilder<AcademicDegreeCubit,AcademicDegreeState>(
                builder: (context, state) {
                  return ExpansionTile(
                    backgroundColor: white,
                    controller: context.read<AcademicDegreeCubit>().controller,
                    showTrailingIcon: false,
                    maintainState: true,
                    shape: OutlineInputBorder(borderSide: BorderSide(color: white)),
                    expandedAlignment: Alignment.bottomCenter,
                    title: CustomTextField(controller: TextEditingController
                      (text: context.read<AcademicDegreeCubit>().selected),
                      obscure: false,
                      isRegistered: false,
                      labelTxt: tr("academic_degree"),
                      suffixIcon:  InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        onTap: (){

                          context.read<AcademicDegreeCubit>().updateExpand();
                        },
                        child: Container(
                          width: 30,
                          alignment: Alignment.center,
                          child: customSvg(name:  context.read<AcademicDegreeCubit>()
                              .controller!.isExpanded ? expand : collapse),
                        ),),),
                    children: <Widget>[
                      context.read<AcademicDegreeCubit>().error == true ?
                      SizedBox() :
                      Container(
                          margin: EdgeInsets.only(left: context.width/13,right: context.width/13),
                          width: context.width,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: black.withOpacity(.1)),
                            borderRadius: BorderRadius.all(Radius.circular(38)),
                          ),// Optional: Add some margin
                          child: context.read<AcademicDegreeCubit>().academicDegreeResponse == null ?
                              SizedBox() :
                          AcademicCheckboxListScreen()


                      ),
                    ],
                  );
                },
              ),
            SizedBox(height: context.height/20,),
              BlocBuilder<AcademicDegreeCubit, AcademicDegreeState>(
                builder: (context, state) {
                  return BlocBuilder<SpecialistsCubit, SpecialistsState>(
                builder: (context, state) {
                  return BlocBuilder<AcademicInfoCubit,AcademicInfoState>(
                builder: (context, state) {
                  return FadeColorButton(
                    isLoading: context.read<AcademicInfoCubit>().loading,
                    btnTitle: tr("save_info")
                ,buttonColor: context.read<AcademicInfoCubit>().buttonColor
                    ,onButtonPressed: (){
                      if(context.read<SpecialistsCubit>().specialistId == null &&
                          context.read<AcademicDegreeCubit>().academicDegreeId == null){
                        msgKey.currentState!.showSnackBar(SnackBar(content:
                        Text(tr("please_select_an_item"),
                          style: TextStyles.textStyleNormal12.copyWith(color: white)
                          ,textScaler: TextScaler.linear(1),)));
                      }else {
                       context.read<AcademicInfoCubit>()
                            .setAcademicInfo(params: AcademicInfoParams(email: widget.email
                            ,specialists: context.read<SpecialistsCubit>().specialistId,
                            academicDegrees: context.read<AcademicDegreeCubit>().academicDegreeId));
                      }

                      },
                    isPressed: false,
                  );},);},);},),
              SizedBox(height: context.height/20,)
          
            ],
          ),
        ),
      ),
    );
  }
}