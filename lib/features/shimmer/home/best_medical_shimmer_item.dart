import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shimmer/shimmer.dart';

class BestMedicalShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
        color: white,
        margin: EdgeInsets.only(left: 5,right: 5),
        width: context.width/1.6,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              child:   SizedBox(
              width: context.width/1.6, height: context.height/4.3,
                child: Shimmer.fromColors(baseColor: black.withOpacity(.05)
                    , highlightColor: Colors.white54
                    ,child: Container(decoration:
                    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),)),
            SizedBox(height: context.height/50,),
            Row(children: [
              SizedBox(
                width: context.width/6, height: context.height/80,
                child: Shimmer.fromColors(baseColor:black.withOpacity(.05)
                  , highlightColor: Colors.white54
                  ,child: Container(decoration:
                  const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),
              SizedBox(width: context.width/20,),

              SizedBox(width: context.width/6, height: context.height/90,
                child: Shimmer.fromColors(baseColor: black.withOpacity(.05)
                  , highlightColor: Colors.white54,child: Container(decoration:
    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),],),
            SizedBox(height: context.height/80,),
            SizedBox(
              width: context.width/2.2, height: context.height/60,
              child: Shimmer.fromColors(baseColor: black.withOpacity(.05)
                , highlightColor: Colors.white54
                ,child: Container(decoration:
                const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),
            SizedBox(height: context.height/100,),
            SizedBox(
              width: context.width/6, height: context.height/90,
              child: Shimmer.fromColors(baseColor: black.withOpacity(.05)
                , highlightColor: Colors.white54
                ,child: Container(decoration:
                const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),
            SizedBox(height: context.height/80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
    width: context.width/6, height: context.height/90,
    child: Shimmer.fromColors(baseColor: white.withOpacity(.2)
    , highlightColor: Colors.white54
    ,child: Container(decoration:
    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),
                SizedBox(width: context.width/60,),
                RatingBarIndicator(
                    rating: double.parse("1"),
                    itemSize: 15,
                    itemCount: 5,
                    itemBuilder: (context,index)=>customSvg(name: star)),
                SizedBox(width: context.width/50,),
                SizedBox(
                  width: context.width/8, height: context.height/20,
                  child: Shimmer.fromColors(baseColor: white.withOpacity(.2)
                    , highlightColor: Colors.white54
                    ,child: Container(decoration:
                    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),)],),
            SizedBox(height: context.height/80,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: context.width/8, height: context.height/20,
                  child: Shimmer.fromColors(baseColor: white.withOpacity(.2)
                    , highlightColor: Colors.white54
                    ,child: Container(decoration:
                    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),),
                SizedBox(width: context.width/20,),
                SizedBox(
                  width: context.width/8, height: context.height/20,
                  child: Shimmer.fromColors(baseColor: white.withOpacity(.2)
                    , highlightColor: Colors.white54
                    ,child: Container(decoration:
                    const BoxDecoration(color: white,borderRadius: BorderRadius.all(Radius.circular(10))),),),)
              ],)
          ],
        ),
    );
  }
}