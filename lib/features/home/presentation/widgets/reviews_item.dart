import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/network_image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsItem extends StatelessWidget {
  const ReviewsItem({super.key, required this.image, required this.description
    , required this.name, required this.specialist, required this.rating});
  final String image;
  final String description;
  final String name;
  final String specialist;
  final String rating;



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(9),
      padding: EdgeInsets.all(35),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(40)),),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(children: [
            ClipOval(
              child: NetWorkImageHandler(image: image, width: context.width/8
                  , height: context.width/8),),
            Spacer(),
            Container(
                alignment: Alignment.center,
                child: customSvg(name: xsocial,width: context.width/15,height: context.width/15))
          ],),
          SizedBox(height: context.height/60,),
          Text("“ $description .”"
            ,style: TextStyles.textStyleNormal20.copyWith(color: orangeBold,
                fontWeight: FontWeight.w400),textScaler: TextScaler.linear(1),),
          SizedBox(height: context.height/60,),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              VerticalDivider(
                thickness: 3.0,
                color: primary,
                indent: 8,
                endIndent: 8,),
              SizedBox(width: context.width/30,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$name"
                    ,style: TextStyles.textStyleBold14.copyWith(color: primary,
                        fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1),),
                  SizedBox(height: context.height/100,),
                  Text("",style: TextStyles.textStyleNormal14
                      .copyWith(color: orange,fontWeight: FontWeight.w500)
                    ,textScaler: TextScaler.linear(1),)
                ],),
              Spacer(),
              Row(children: [
                RatingBarIndicator(
                    itemCount: 1,
                    itemSize: 20,
                    rating: double.parse(rating.toString()),
                    itemBuilder: (context,index)=>customSvg(name: star,color: gold)),
                SizedBox(width: context.width/60,),
                Text("$rating",style: TextStyles.textStyleBold18.copyWith(color: primary),
                  textScaler: TextScaler.linear(1),)
              ],)
            ],),
          )
        ],
      ),
    );
  }

}