import 'dart:math' as math;

import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/fade_button.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:dr_nada_salma_med_edu_plat/main.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SecondSplash extends StatelessWidget {
  const SecondSplash({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.height/14.5,),
               Container(
                 alignment: Alignment.center,
                 margin: EdgeInsets.only(left: context.width/20,right: context.width/20),
                 child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          child: ImageHandler(image: doctor, width: context.width,
                              height: context.height/2.9),
                        ),),
                SizedBox(height: context.height/32,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBox(width: context.width/20,),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5,top: 13,bottom: 13),
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.all(Radius.circular(38.0))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: context.width/40,),
                            Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.all(Radius.circular(23))),
                              padding: EdgeInsets.only(left: 10,right: 10,top: 5.5,bottom: 5.5),
                              child: Text(tr("new"),style: TextStyles.textStyleNormal10.copyWith
                                (fontWeight: FontWeight.w600),textScaler: TextScaler.linear(1)),),
                            SizedBox(width: context.width/50,),
                            Text(tr("best_medical_service"),
                              style: TextStyles.textStyleNormal11
                                  .copyWith(fontWeight: FontWeight.w600,color: white)
                                ,textScaler: TextScaler.linear(1)),
                            SizedBox(width: context.width/30,),
                            context.locale.languageCode == "ar" ?
                            Transform.rotate(
                              angle: 180 * math.pi / 180,
                              child:  Container(
                                  alignment: Alignment.center,
                                  child: customSvg(name: forward,width: context.width/5
                                      ,height: context.height/60)),

                            ) : Container(
                                alignment: Alignment.center,
                                child: customSvg(name: forward,width: context.width/5
                                    ,height: context.height/60)),
                            SizedBox(width: context.width/30,)
                          ],),),
                      SizedBox(width: context.width/20,),
                    ],),
                ),
                SizedBox(height: context.height/35,),
                Container(
                    padding: EdgeInsets.only(left: context.width/20,right: context.width/20 ),
                    child: Text(tr("expert_led"),style: TextStyles.textStyleBold28
                        .copyWith(color: orangeBold),textScaler: TextScaler.linear(1),)),
                SizedBox(height: context.height/50,),
                Container(
                  padding: EdgeInsets.only(left: context.width/20,right: context.width/20),
                  child: Text(tr("discover_tailored_medical")
                  ,style: TextStyles.textStyleNormal12.copyWith
                      (color: primary,fontWeight: FontWeight.w600),textScaler:
                    TextScaler.linear(1),),),
                SizedBox(height: context.height/35,),
           Row(
                   children: [
                     Stack(
                       alignment: Alignment.centerLeft,
                       children: [
                         Container(
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(color: white)
                           ),
                           alignment: Alignment.center,
                           margin: EdgeInsets.only(left: context.width/20),
                           child: ClipOval(child: ImageHandler
                             (image: profile1, width: context.width/7
                               , height: context.width/7)),
                         ),
                         Container(
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(color: white)
                           ),
                           alignment: Alignment.center,
                           margin: EdgeInsets.only(left: context.width/6),
                           child: ClipOval(child: ImageHandler
                             (image: profile2, width: context.width/7
                               , height: context.width/7)),
                         ),
                         Container(
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               border: Border.all(color: white)
                           ),
                           margin: EdgeInsets.only(left: context.width/3.9),
                           child: ClipOval(child: ImageHandler
                             (image: profile3, width: context.width/7
                               , height: context.width/7)),
                         ),
                         Container(
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             border: Border.all(color: white)
                           ),
                           margin: EdgeInsets.only(left: context.width/2.7),
                           child: ClipOval(child: ImageHandler
                             (image: profile4, width: context.width/7
                               , height: context.width/7)),
                         ),],),
                     SizedBox(width: context.width/20,),
                     Flexible(
                       fit: FlexFit.loose,
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                         Text("More than 1500+ clients..",style:
                         TextStyles.textStyleNormal10.copyWith(color: primary,
                             fontWeight: FontWeight.w600),
                           overflow: TextOverflow.ellipsis,textScaler: TextScaler.linear(1),),
                         SizedBox(height: context.height/110,),
                         Row(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.center,
                             children: [
                               Flexible(
                                 child: Text("5.0",style: TextStyles.textStyleNormal10
                                     .copyWith(color: primary,fontWeight: FontWeight.w600
                                     ,overflow: TextOverflow.ellipsis),textScaler:
                                 TextScaler.linear(1),),
                               ),
                               SizedBox(width: context.width/70,),
                               RatingBarIndicator(
                                 rating: 5.0,
                                 itemCount: 5,
                                 itemPadding: EdgeInsets.only(left: 2,right: 2),
                                 itemSize: 19.0,
                                 physics: BouncingScrollPhysics(),
                                 itemBuilder: (context, _) => customSvg(name: star),
                               ),
                             ],),],),
                     )],),
                SizedBox(height: context.height/22),
                BlocBuilder<SplashCubit, SplashState>(
                  builder: (context, state) {
                    return FadeColorButton(onButtonPressed: (){
                  context.read<SplashCubit>().setButtonAnimation();
                  Future.delayed(Duration(milliseconds: 300),()=> navKey
                      .currentContext!.pushReplacementNamed(name: loginSc));
          
                },buttonColor: context.read<SplashCubit>().buttonColor,
                    isPressed: 
                    context.read<SplashCubit>().isPressed!, btnTitle: tr("get_started"),);},),
                SizedBox(height: context.height/20,),
          
              ],
          ),
        ),
      ),
    );
  }

}