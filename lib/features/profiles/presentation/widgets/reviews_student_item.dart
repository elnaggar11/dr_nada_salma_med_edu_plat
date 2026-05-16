import 'package:dr_nada_salma_med_edu_plat/core/constants/colors.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/dieminsions.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/images.dart';
import 'package:dr_nada_salma_med_edu_plat/core/constants/styles.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/image_handler.dart';
import 'package:dr_nada_salma_med_edu_plat/core/widgets/svg_handler.dart';
import 'package:flutter/material.dart';

class ReviewsStudentItem extends StatelessWidget {
  final String img;

  const ReviewsStudentItem({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width/.9,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(left: context.width/30
          ,right: context.width/30,top: context.width/30,bottom: context.width/30),
      decoration: BoxDecoration(
          color: greyLight,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          shape: BoxShape.rectangle),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: ImageHandler(image: img, width: context.width/8, height: context.width/8),),
              Spacer(),
              customSvg(name: xsocial,width: context.width/18,height: context.width/18)

            ],),

          SizedBox(height: context.height/60,),
          Container(
            margin: EdgeInsets.only(left: context.width/30,right: context.width/30),
            child: Text("“ The course was amazing and greatly boosted my confidence in my medical skills .”"
              ,style: TextStyles.textStyleNormal20
                .copyWith(color: orangeBold
                  ,fontWeight: FontWeight.w400)
              ,textScaler: TextScaler.linear(1),),
          ),

          SizedBox(height: context.height/60,),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalDivider(color: primary,thickness: 3,indent: 2,endIndent: 2,),
                SizedBox(width: context.width/20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text("Abdullah Al-Walidi",
                    style: TextStyles.textStyleBold14
                        .copyWith(color: primary,fontWeight: FontWeight.w700)
                    ,textScaler: TextScaler.linear(1),),
                    SizedBox(height: context.height/60,),
                    Text("medical student",
                      style: TextStyles.textStyleNormal14
                          .copyWith(color: orange,fontWeight: FontWeight.w500)
                      ,textScaler: TextScaler.linear(1),),
                ],),
              ],),
          ),

        ],
      ),
    );
  }
}