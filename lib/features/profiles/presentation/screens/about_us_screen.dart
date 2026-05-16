import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/custom_app_bar.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/profiles/presentation/cubit/about_us_cubit/about_us_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
  
}

class _AboutUsScreenState extends State<AboutUsScreen> {


  @override
  void initState() {
    context.read<AboutUsCubit>().getAboutUs();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          appBarInd: 0,
          widget: SizedBox(),title: tr("about_us"),status: false,context: context),
      
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(color: white),
        child: BlocBuilder<AboutUsCubit, AboutUsState>(
          builder: (context, state) {
    return context.read<AboutUsCubit>().loading == true ?
         Center(child: SpinKitPulse(color: primary,size: 40,)) :
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1.${context.read<AboutUsCubit>().aboutUsResponse!.data!.titleOne}"
                          ,textScaler: TextScaler.linear(1),style: TextStyles
                              .textStyleBold17.copyWith(color: primary),),
                        SizedBox(height: context.height/70,),
                        Text(context.read<AboutUsCubit>().aboutUsResponse!.data!
                            .descriptionOne,style:
                        TextStyles.textStyleNormal13.copyWith(color: primary)
                          ,textScaler: TextScaler.linear(1),)
                      ],),
                  ),),],),
            SizedBox(height: context.height/50,),
            Container(
              margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
              child: Row(
                children: [
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: NetWorkImageHandler(image: context.read<AboutUsCubit>()
                        .aboutUsResponse!.data!.imageOne, width: context.width
                        , height: context.height/5),
                  ))
                ],
              ),),
            SizedBox(height: context.height/20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2.${context.read<AboutUsCubit>().aboutUsResponse!.data!.titleTwo}"
                          ,textScaler: TextScaler.linear(1),style: TextStyles
                              .textStyleBold17.copyWith(color: primary),),
                        SizedBox(height: context.height/70,),
                        Text(context.read<AboutUsCubit>().aboutUsResponse!.data!
                            .descriptionTwo,style:
                        TextStyles.textStyleNormal13.copyWith(color: primary)
                          ,textScaler: TextScaler.linear(1),)
                      ],),
                  ),),],),
            SizedBox(height: context.height/50,),
            Container(
              margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
              child: Row(
                children: [
                  Expanded(child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: NetWorkImageHandler(image: context.read<AboutUsCubit>()
                        .aboutUsResponse!.data!.imageTwo, width: context.width
                        , height: context.height/5),
                  ))
                ],
              ),),
          ],
        ),
      );
  },
),
        
      ),
    );
  }
}