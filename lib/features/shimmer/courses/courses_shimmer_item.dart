import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CoursesShimmerItem extends StatelessWidget {
  const CoursesShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(7),
        child: Row(
          children: [
            SizedBox(width: context.width/3.5, height: context.width/3.5,
                  child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                    , highlightColor: Colors.white54
                    ,child: Container(decoration:
                    BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      shape: BoxShape.rectangle,
                      color: white,)),),),

            SizedBox(width: context.width/50,),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    SizedBox(width: context.width/7, height: context.width/40,
                      child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                        , highlightColor: Colors.white54
                        ,child: Container(decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          shape: BoxShape.rectangle,
                          color: white,)),),),
                    SizedBox(width: context.width/20,),
                    SizedBox(width: context.width/7, height: context.width/40,
                      child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                        , highlightColor: Colors.white54
                        ,child: Container(decoration:
                        BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          shape: BoxShape.rectangle,
                          color: white,)),),),],),


                  SizedBox(height: context.height/200,),

                  SizedBox(width: context.width/4, height: context.width/30,
                    child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                      , highlightColor: Colors.white54
                      ,child: Container(decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        shape: BoxShape.rectangle,
                        color: white,)),),),
                  SizedBox(height: context.height/140,),
        SizedBox(width: context.width/8, height: context.width/50,
          child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
            , highlightColor: Colors.white54
            ,child: Container(decoration:
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(22)),
              shape: BoxShape.rectangle,
              color: white,)),),),
                  SizedBox(height: context.height/80,),

                  SizedBox(height: context.height/80,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  SizedBox(width: context.width/6, height: context.width/40,
                    child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                      , highlightColor: Colors.white54
                      ,child: Container(decoration:
                      BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22)),
                        shape: BoxShape.rectangle,
                        color: white,)),),),
                      SizedBox(width: context.width/20,),
                      SizedBox(width: context.width/6, height: context.width/40,
                        child: Shimmer.fromColors(baseColor:black.withOpacity(.09)
                          , highlightColor: Colors.white54
                          ,child: Container(decoration:
                          BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            shape: BoxShape.rectangle,
                            color: white,)),),),
                    ],)
                ],
              ),
            ),
          ],
        ),);
  }

}