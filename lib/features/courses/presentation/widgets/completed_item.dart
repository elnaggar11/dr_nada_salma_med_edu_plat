import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/screens.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/features/home/domain/entities/courses_details_params.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CompletedItem extends StatelessWidget {
  final String title;
  final String img;
  final String progress;
  final String points;
  final String slug;
  final String totalHours;
  final String categoryName;
  final String lectureNum;
  final String sectionNum;

  CompletedItem({required this.title,required this.img,required this.progress
    ,required this.points, required this.slug, required this.totalHours, required this.categoryName, required this.lectureNum, required this.sectionNum});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        CoursesDetailsParams params = CoursesDetailsParams(slug: slug,status: "completed");
        context.pushNamed(name: courseDetailsSc,args: params);
      },
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(9),
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: NetWorkImageHandler(image: img, width: context.width/3.2,
                          height: context.width/3.5),),
                    Container(
                      margin: EdgeInsets.all(7),
                      padding: EdgeInsets.all(11),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: white,),
                      child: customSvg(name: heart),)],),
                SizedBox(width: context.width/50,),
                Flexible(
                  fit: FlexFit.loose,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(categoryName,style: TextStyles.textStyleBold10
                            .copyWith(fontWeight: FontWeight.w600
                            ,color: primary)
                          ,textScaler: TextScaler.linear(1),),
                        SizedBox(width: context.width/20,),
                        /*Text("+$points points",style: TextStyles.textStyleBold10
                            .copyWith(fontWeight: FontWeight.w600,color: primary)
                          ,textScaler: TextScaler.linear(1),),*/],),


                      SizedBox(height: context.height/110,),

                      Text(title,style: TextStyles.textStyleBold16.copyWith
                        (fontWeight: FontWeight.w800,color: orangeBold)
                        ,textScaler: TextScaler.linear(1),overflow: TextOverflow.ellipsis,),
                      SizedBox(height: context.height/120,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text("${sectionNum} sections",style: TextStyles.textStyleBold10.copyWith
                              (color: primary,fontWeight: FontWeight.w600),
                              textScaler: TextScaler.linear(1),overflow: TextOverflow.ellipsis,maxLines: 1,),
                          ),
                          customSvg(name: elipse),
                          Flexible(
                            child: Text("${lectureNum} lectures",style: TextStyles.textStyleNormal10.copyWith
                              (color: primary,fontWeight: FontWeight.w600)
                              ,textScaler: TextScaler.linear(1),overflow: TextOverflow.ellipsis,maxLines: 1,),),
                          customSvg(name: elipse),
                          Flexible(
                            child: Text("${totalHours}",style: TextStyles.textStyleNormal10.copyWith
                              (color: primary,fontWeight: FontWeight.w600)
                              ,textScaler: TextScaler.linear(1),overflow: TextOverflow.ellipsis,maxLines: 1,),),
                        ],)
                    ],
                  ),
                ),],),
            SizedBox(height: context.height/50,),
            Row(children: [
              Container(
                padding: EdgeInsets.only(
                    left: context.width/60,right: context.width/60,
                    top: context.height/80,bottom: context.height/80),
                decoration: BoxDecoration(
                    color: accent,
                    borderRadius: BorderRadius.all(Radius.circular(38))),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: context.width/40,bottom: context.width/40,
                          left: context.width/24,right: context.width/24),
                      decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.all(Radius.circular(23))),
                      child: customSvg(name: completed,color: white),),
                    SizedBox(width: context.width/120,),
                    Text(tr("completed"),style: TextStyles.textStyleNormal10
                        .copyWith(fontWeight: FontWeight.w500,color: primary),
                      textScaler: TextScaler.linear(1),),
                    SizedBox(width: context.width/120,),],),),
              Spacer(),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
                        child: Text("$progress%",style: TextStyles.textStyleNormal12
                            .copyWith(fontWeight: FontWeight.w600,
                            color: accent),textScaler: TextScaler.linear(1),)),
                    SizedBox(height: context.height/80,),
                    LinearPercentIndicator(
                      percent: double.parse(progress),
                      linearStrokeCap: LinearStrokeCap.round,
                      barRadius: Radius.circular(6.0),
                      progressColor: accent,
                    ),
                  ],
                ),
              )
            ],)
          ],
        ),
      ),
    );
  }

}